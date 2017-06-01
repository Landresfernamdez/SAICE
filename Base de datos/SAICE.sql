
CREATE DOMAIN a_telefono CHAR(9) NOT NULL CONSTRAINT CHK_telefono
CHECK (VALUE SIMILAR TO '[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]');

CREATE DOMAIN a_correos CHAR(30) NOT NULL CONSTRAINT CHK_correo
CHECK(VALUE SIMILAR TO '[A-z]%@[A-z]%.[A-z]%');

CREATE DOMAIN a_cedula CHAR(9)NOT NULL CONSTRAINT CHK_cedula 
CHECK(VALUE SIMILAR TO '[0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9]');

CREATE DOMAIN a_carnet CHAR(11) NOT NULL CONSTRAINT CHK_carnet 
CHECK (VALUE SIMILAR TO '[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9][0-9][0-9]');


CREATE DOMAIN id_empresa CHAR(9) NOT NULL CONSTRAINT CHK_id_empresa 
CHECK (VALUE SIMILAR TO 'Em-[0-9][0-9][0-9][0-9][0-9][0-9]');

CREATE DOMAIN d_secciones CHAR(10) NOT NULL CONSTRAINT CHK_id_secciones 
CHECK (VALUE SIMILAR TO '[0-9][0-9]-[0-9][0-9]/[0-9][0-9][0-9][0-9]');



--Tabla eventos
 CREATE TABLE Eventos(
	ID_Evento Serial primary key NOT NULL,
	Nombre VARCHAR(30) NOT NULL,
	Descripcion VARCHAR(100) NULL,
	FechaInicio DATE NOT NULL,
	FechaFinal DATE NOT NULL
                    );

--Tabla personas
 CREATE TABLE Personas(
		cedula a_cedula primary key ,
		Nombre CHAR(30) NOT NULL,
		Apellido1 CHAR(30) NOT NULL,
		Apellido2 CHAR(30) NULL,
		provincia VARCHAR(30) NOT NULL,
		canton VARCHAR(30) NOT NULL,
		distrito VARCHAR(30) NOT NULL,
		detalle VARCHAR(100) NULL
                      );
--Tabla eventos funcionarios
CREATE TABLE Funcionarios(
		cedula a_cedula primary key ,
		carnet char(10) NOT NULL,
		CONSTRAINT FK_cedula_personas_funcionarios FOREIGN KEY (cedula) REFERENCES Personas
                         );
--Tabla eventos funcionarios
CREATE TABLE EF(
	cedula a_cedula ,
	ID_Evento Serial NOT NULL,
	ROL VARCHAR(30) NOT NULL,
        CONSTRAINT PK_funcionarios_eventos PRIMARY KEY(cedula,ID_evento), 
	CONSTRAINT FK_cedula_Funcionarios_eventos FOREIGN KEY(cedula) REFERENCES Funcionarios,
	CONSTRAINT FK_idEvento_Funcionarios FOREIGN KEY (ID_Evento) REFERENCES Eventos
               );
--Tabla correos personas               
CREATE TABLE Correos_p(
	cedula a_cedula PRIMARY KEY,
	correo a_correos ,
	CONSTRAINT FK_cedula_personas_correos FOREIGN KEY(cedula) REFERENCES Personas
                      );
--Tabla telefonos personas 
CREATE TABLE Telefonos_p(
	cedula a_cedula primary key,
	telefono a_telefono,
	CONSTRAINT FK_cedula_persona_telefonos FOREIGN KEY(cedula) REFERENCES Personas
                        );

--Tabla secciones funcionarios
CREATE TABLE SF(
	Id_secciones Serial NOT NULL ,
	cedula a_cedula,
	CONSTRAINT PK_funcionario_secciones PRIMARY KEY (Id_secciones,cedula),
	CONSTRAINT FK_id_secciones_funcionarios_secciones FOREIGN KEY(Id_secciones)REFERENCES Secciones,
	CONSTRAINT FK_cedula_funcionarios_secciones FOREIGN KEY(cedula) REFERENCES Funcionarios 
               ); 
--Tabla polizas
CREATE TABLE Polizas(
	ID_Poliza Serial NOT NULL PRIMARY KEY,
	Descripcion VARCHAR(100) NULL,
	Monto INT NOT NULL,
	Fecha_vencimiento DATE NOT NULL,
	Aseguradora VARCHAR(30) NOT NULL
                    );
--Tabla estudiantes
CREATE  TABLE Estudiantes(
	cedula a_cedula PRIMARY KEY,
	carnet a_carnet,
	ID_Poliza serial NOT NULL,
	CONSTRAINT FK_polizas_estudiantes FOREIGN KEY(ID_Poliza) REFERENCES Polizas 	
                        );       
--Tabla contactos
CREATE TABLE Contactos(
	cedula a_cedula PRIMARY KEY ,
	Puesto VARCHAR(30) NOT NULL,
	CONSTRAINT FK_cedula_personas_contactos FOREIGN KEY(cedula)REFERENCES Personas
                      );
--Tabla empresas
CREATE TABLE Empresas(
	ID_Empresa id_empresa NOT NULL PRIMARY KEY,
	Nombre CHAR(30) NOT NULL,
	provincia VARCHAR(30) NOT NULL,
	canton VARCHAR(30) NOT NULL,
	distrito VARCHAR(30) NOT NULL,
	detalle VARCHAR(100) NULL
                    );
--Tabla contactos empresas
CREATE TABLE CE(
	cedula a_cedula,
	ID_Empresa id_empresa NOT NULL,
	CONSTRAINT PK_Contactos_de_empresa PRIMARY KEY(cedula,ID_Empresa),
	CONSTRAINT FK_cedula_contacto_empresa FOREIGN KEY(cedula)REFERENCES Contactos,
	CONSTRAINT FK_id_empresa_de_contacto FOREIGN KEY(ID_Empresa)REFERENCES Empresas
               );         
--Tabla telefonos empresas           
CREATE TABLE Telefonos_E(
		ID_Empresa id_empresa NOT NULL PRIMARY KEY,
		telefono a_telefono,
		CONSTRAINT FK_id_empresa_telefonos FOREIGN KEY(ID_Empresa) REFERENCES Empresas
                        );
--Tabla correos empresas
CREATE TABLE Correos_E(
	ID_Empresa id_empresa NOT NULL PRIMARY KEY,
	correo a_correos ,
	CONSTRAINT FK_id_empresa_correos FOREIGN KEY(ID_Empresa) REFERENCES Empresas
                );
                
--Tabla practicas
CREATE TABLE PRACTICAS(
		ID_Practicas Serial NOT NULL PRIMARY KEY,
		Fecha_inicio DATE NOT NULL,
		Fecha_final DATE NOT NULL,
		nota int  NOT NULL,
		estado CHAR(1) NOT NULL,
		cedula a_cedula,
		ID_Empresa id_empresa NOT NULL,
		CONSTRAINT FK_id_empresa_practicas FOREIGN KEY(ID_Empresa) REFERENCES Empresas,
		CONSTRAINT FK_cedula_estudiante_Practicas FOREIGN KEY(cedula) REFERENCES Estudiantes
                      );
--Tabla giras
CREATE TABLE Giras(
	ID_Gira Serial NOT NULL PRIMARY KEY,
	Fecha_inicio DATE NOT NULL,
	Fecha_final DATE NOT NULL,
	costo INT NOT NULL,
	duracion TIME NOT NULL,
	provincia VARCHAR(30) NOT NULL,
	canton VARCHAR(30) NOT NULL,
	distrito VARCHAR(30) NOT NULL,
	detalle VARCHAR(100) NULL
                  );
--Tabla secciones grupos
CREATE TABLE SG(
	Id_secciones d_secciones NOT NULL,
	ID_Gira serial NOT NULL,
	CONSTRAINT PK_Secciones_Giras PRIMARY KEY(Id_secciones,ID_Gira),
	CONSTRAINT FK_id_secciones_giras FOREIGN KEY(Id_secciones)REFERENCES Secciones,
	CONSTRAINT FK_id_giras_secciones FOREIGN KEY(ID_Gira)REFERENCES Giras
               );
--Tabla estudiantes secciones
CREATE TABLE ES(
	Id_secciones Serial NOT NULL,
	cedula a_cedula,
	CONSTRAINT PK_Estudiantes_secciones PRIMARY KEY(Id_secciones,cedula),
	CONSTRAINT FK_Id_secciones_Estudiantes FOREIGN KEY(Id_secciones) REFERENCES Secciones,
	CONSTRAINT FK_cedula_estudiantes_secciones FOREIGN KEY(cedula)REFERENCES Estudiantes
               );
--Tabla eventos giras funcionarios
CREATE TABLE  GE(
	ID_Giras Serial NOT NULL,
	ID_Empresa id_empresa NOT NULL,
	CONSTRAINT PK_Giras_empresas PRIMARY KEY(ID_Giras,ID_Empresa),
	CONSTRAINT FK_ID_empresa_Giras FOREIGN KEY(ID_Empresa)REFERENCES Empresas,
	CONSTRAINT FK_ID_giras_empresas FOREIGN KEY(ID_Giras)REFERENCES Giras
               ); 

------------------Funciones agregar--------------------

--Agregar eventos REVISAR
create or replace Function insertar_eventos(
	E_ID_Evento Serial NOT NULL,
	E_ID_Evento CHAR(7),
	E_Nombre VARCHAR(30),
	E_Descripcion VARCHAR(100),
	E_FechaInicio DATE,
	E_FechaFinal DATE
)returns void as
$BODY$
Begin
	raise notice 'Insertando Evento';
	insert into Eventos values (E_ID_Evento,E_Nombre,E_Descripcion,E_FechaInicio,E_FechaFinal);
	raise notice 'Se inserto evento';
end $BODY$
language plpgsql;



--------------------------CRUD de estudiantes-----------------------------------------------
--Agregar Estudiantes falta al insertar que lleve conexion de polizas
create or replace function insertar_Estudiante(
	p_carnet a_carnet,
	p_cedula a_cedula,
	p_telefono a_telefono,
	p_correos a_correos,
	p_Nombre CHAR(30),
	p_Apellido1 CHAR(30),
	p_Apellido2 CHAR(30),
	p_provincia VARCHAR(30),
	p_canton VARCHAR(30),
	p_distrito VARCHAR(30),
	p_detalle VARCHAR(100),
	p_poliza int
	
)returns void as
$BODY$
Begin
	raise notice 'Insertando';
	insert into personas values (p_cedula,p_Nombre,p_Apellido1,p_Apellido2,p_provincia,p_canton,p_distrito,p_detalle);
	insert into telefonos_p values(p_cedula,p_telefono);
	insert into correos_p values(p_cedula,p_correos);
	insert into Estudiantes values (p_cedula,p_carnet,p_poliza);
	raise notice 'Se inserto Estudiante';
end $BODY$
language plpgsql;

--Funcion que se encarga de eliminar un estudiante
		CREATE OR REPLACE FUNCTION eliminarEstudiante
		( 
			p_cedula a_cedula
		) RETURNS VOID
		AS
		$BODY$
		BEGIN
			delete  from Estudiantes where cedula=p_cedula;
			delete  from correos_p where cedula=p_cedula;
			delete  from telefonos_p where cedula=p_cedula;
			delete  from personas where cedula=p_cedula;
		END;
		$BODY$ 
		LANGUAGE plpgsql;


--Se encarga de recuperar los estudiantes
 
select p.cedula,p.nombre,p.apellido1,p.apellido2,p.provincia,
p.canton,p.distrito,p.detalle,e.carnet,e.id_poliza,t.telefono,cp.correo from personas
p inner join estudiantes e on e.cedula=p.cedula inner join 
correos_p cp on cp.cedula=p.cedula inner join telefonos_p t on t.cedula=p.cedula;

---Funcion que se encarga de modificar un estudiante
CREATE OR REPLACE FUNCTION actualizarEstudiante
		( 
			p_carnet a_carnet,
			p_cedula a_cedula,
			p_telefono a_telefono,
			p_correos a_correos,
			p_Nombre CHAR(30),
			p_Apellido1 CHAR(30),
			p_Apellido2 CHAR(30),
			p_provincia VARCHAR(30),
			p_canton VARCHAR(30),
			p_distrito VARCHAR(30),
			p_detalle VARCHAR(100),
			p_poliza VARCHAR(20)
		) RETURNS VOID
		AS
		$BODY$
		BEGIN
			update  Personas  set 
				nombre=p_nombre,
				apellido1=p_Apellido1,
				apellido2=p_Apellido2,
				provincia=p_provincia,
				canton=p_canton,
				distrito=p_distrito,
				detalle=p_detalle
				where cedula=p_cedula ;
			p_poliza=cast(p_poliza as int);
			update correos_p set correo=p_correos where cedula=p_cedula ;
			update telefonos_p  set telefono=p_telefono where cedula=p_cedula;
			update Estudiantes set id_poliza=cast(p_poliza as int) where cedula=p_cedula and carnet=p_carnet;
		END;
		$BODY$ 
		LANGUAGE plpgsql;

		
--------------------------------------------CRUD de funcionarios------------------------------------------------------------------

---Obtener funcionario
select p.cedula,p.nombre,p.apellido1,p.apellido2,p.provincia,
				p.canton,p.distrito,p.detalle,f.carnet,t.telefono,cp.correo from personas
				p inner join funcionarios f on f.cedula=p.cedula inner join 
				correos_p cp on cp.cedula=p.cedula inner join telefonos_p t on t.cedula=p.cedula;
--Agregar funcionarios
create or replace function insertar_funcionario(
			p_carnet CHAR(10),
			p_cedula a_cedula,
			p_telefono a_telefono,
			p_correos a_correos,
			p_Nombre CHAR(30),
			p_Apellido1 CHAR(30),
			p_Apellido2 CHAR(30),
			p_provincia VARCHAR(30),
			p_canton VARCHAR(30),
			p_distrito VARCHAR(30),
			p_detalle VARCHAR(100)
)returns void as
$BODY$
Begin
	raise notice 'Insertando';
	insert into personas values (p_cedula,p_Nombre,p_Apellido1,p_Apellido2,p_provincia,p_canton,p_distrito,p_detalle);
	insert into telefonos_p values(p_cedula,p_telefono);
	insert into correos_p values(p_cedula,p_correos);
	insert into funcionarios values (p_cedula,p_carnet);
	raise notice 'Se inserto Funcionario';
end $BODY$
language plpgsql;

---actualizar funcionario
CREATE OR REPLACE FUNCTION actualizarFuncionario
		( 
			p_carnet VARCHAR(10),
			p_cedula a_cedula,
			p_telefono a_telefono,
			p_correos a_correos,
			p_Nombre CHAR(30),
			p_Apellido1 CHAR(30),
			p_Apellido2 CHAR(30),
			p_provincia VARCHAR(30),
			p_canton VARCHAR(30),
			p_distrito VARCHAR(30),
			p_detalle VARCHAR(100)
		) RETURNS VOID
		AS
		$BODY$
		BEGIN
			update  Personas  set 
				nombre=p_nombre,
				apellido1=p_Apellido1,
				apellido2=p_Apellido2,
				provincia=p_provincia,
				canton=p_canton,
				distrito=p_distrito,
				detalle=p_detalle
				where cedula=p_cedula ;
			update correos_p set correo=p_correos where cedula=p_cedula ;
			update telefonos_p  set telefono=p_telefono where cedula=p_cedula;
		END;
		$BODY$ 
		LANGUAGE plpgsql;

----eliminar funcionario
CREATE OR REPLACE FUNCTION eliminarFuncionario
		( 
			p_cedula a_cedula
		) RETURNS VOID
		AS
		$BODY$
		BEGIN
			delete  from Funcionarios where cedula=p_cedula;
			delete  from correos_p where cedula=p_cedula;
			delete  from telefonos_p where cedula=p_cedula;
			delete  from personas where cedula=p_cedula;
		END;
		$BODY$ 
		LANGUAGE plpgsql;

-------------------------------------------------------CRUD empresas----------------------------------------------------------------------
--Agregar empresa
create or replace function insertar_empresa(
			e_id_empresa id_empresa,
			e_nombre CHAR(30),
			e_provincia VARCHAR(30),
			e_canton VARCHAR(30),
			e_distrito VARCHAR(30),
			e_detalle VARCHAR(100),
			e_telefono a_telefono,
			e_correos a_correos
			
)returns void as
$BODY$
Begin
	raise notice 'Insertando';
	insert into Empresas values (e_id_empresa,e_nombre,e_provincia,e_canton,e_distrito,e_detalle);
	insert into Telefonos_E values(e_id_empresa,e_telefono);
	insert into Correos_E values(e_id_empresa,e_correos);
	raise notice 'Se inserto empresa';
end $BODY$
language plpgsql;
-----------------------------------CRUD Contactos---------------------------------
-----obtener contacto
select p.cedula,p.nombre,p.apellido1,p.apellido2,p.provincia,
				p.canton,p.distrito,p.detalle,t.telefono,cp.correo,c.puesto,r.ID_empresa from personas
				p inner join contactos c on c.cedula=p.cedula inner join 
				correos_p cp on cp.cedula=p.cedula inner join telefonos_p t on t.cedula=p.cedula inner join ce
				r on r.cedula=p.cedula;
---insertar contacto
create or replace function insertar_contacto(
			p_puesto CHAR(30),
			p_cedula a_cedula,
			p_telefono a_telefono,
			p_correos a_correos,
			p_Nombre CHAR(30),
			p_Apellido1 CHAR(30),
			p_Apellido2 CHAR(30),
			p_provincia VARCHAR(30),
			p_canton VARCHAR(30),
			p_distrito VARCHAR(30),
			p_detalle VARCHAR(100),
			p_id_empresa id_empresa
)returns void as
$BODY$
Begin
	raise notice 'Insertando';
	insert into personas values (p_cedula,p_Nombre,p_Apellido1,p_Apellido2,p_provincia,p_canton,p_distrito,p_detalle);
	insert into telefonos_p values(p_cedula,p_telefono);
	insert into correos_p values(p_cedula,p_correos);
	insert into contactos values (p_cedula,p_puesto);
	insert into ce values (p_cedula,p_id_empresa);
	raise notice 'Se inserto Funcionario';
end $BODY$
language plpgsql;
------modificar un contacto

CREATE OR REPLACE FUNCTION actualizarContacto
		( 
			p_puesto VARCHAR(30),
			p_cedula a_cedula,
			p_telefono a_telefono,
			p_correos a_correos,
			p_Nombre CHAR(30),
			p_Apellido1 CHAR(30),
			p_Apellido2 CHAR(30),
			p_provincia VARCHAR(30),
			p_canton VARCHAR(30),
			p_distrito VARCHAR(30),
			p_detalle VARCHAR(100),
			p_id_empresa id_empresa
		) RETURNS VOID
		AS
		$BODY$
		BEGIN
			update  Personas  set 
				nombre=p_nombre,
				apellido1=p_Apellido1,
				apellido2=p_Apellido2,
				provincia=p_provincia,
				canton=p_canton,
				distrito=p_distrito,
				detalle=p_detalle
				where cedula=p_cedula ;
			update correos_p set correo=p_correos where cedula=p_cedula ;
			update telefonos_p  set telefono=p_telefono where cedula=p_cedula;
			update contactos set puesto=p_puesto where cedula=p_cedula;
		END;
		$BODY$ 
		LANGUAGE plpgsql;

---eliminar contacto

CREATE OR REPLACE FUNCTION eliminarContacto
		( 
			p_cedula a_cedula
		) RETURNS VOID
		AS
		$BODY$
		BEGIN
			delete from ce where cedula=p_cedula;
			delete  from contactos where cedula=p_cedula;
			delete  from correos_p where cedula=p_cedula;
			delete  from telefonos_p where cedula=p_cedula;
			delete  from personas where cedula=p_cedula;
		END;
		$BODY$ 
		LANGUAGE plpgsql;


--Insertar Polizas
create or replace function insertar_Polizas(
	p_Descripcion VARCHAR(100),
	p_Monto INT,
	p_Fecha_vencimiento varchar(30),
	p_Aseguradora VARCHAR(30)

)returns void as
$BODY$
Begin
	raise notice 'Insertando';
	insert into polizas(Descripcion,Monto,Fecha_vencimiento,Aseguradora) values (p_Descripcion,p_Monto,cast(p_Fecha_vencimiento as date),p_Aseguradora);	
	raise notice 'Se inserto Poliza';
end $BODY$
language plpgsql;





---------------Modificar polizas----------------
CREATE OR REPLACE FUNCTION modificar_polizas
(
	p_ID_Poliza int,
	p_Descripcion VARCHAR(100),
	p_Monto INT,
	p_Fecha_vencimiento varchar(30),
	p_Aseguradora VARCHAR(30)

) RETURNS VOID
AS
$BODY$
BEGIN
    update polizas set
	Descripcion=p_Descripcion,
	Monto=p_Monto,
	Fecha_vencimiento=cast(p_Fecha_vencimiento as date),
	Aseguradora=p_Aseguradora

    where ID_poliza=p_ID_poliza;
END;
$BODY$
LANGUAGE plpgsql;


--borrado polizas
CREATE OR REPLACE FUNCTION borrar_polizas
(
	p_ID_poliza int
) RETURNS VOID
AS
$BODY$
BEGIN
    delete from polizas where id_poliza=p_id_poliza;
END;
$BODY$
LANGUAGE plpgsql;








select * from contactos
select * from ce
select * from empresas
select * from correos_e 
select * from telefonos_e 
select * from polizas
select * from Estudiantes
select * from personas 
select * from correos_p 
select * from telefonos_p 
select * from funcionarios


select insertar_empresa('Em-000000','Avantica','Alajuela','San Carlos','Quesada','lol','8888-9999','ava@ava.ava')
select insertar_contacto('gerente','1-222-333','3333-3333',
                    'landresf12@hotmail.com','Andres ','Hernandez',
                    'Calderon','Alajuela','San Ramon','Piedades Sur','Profesor','Em-000000');
select eliminarContacto('1-222-333');

 select actualizarContacto('Desarrollador','1-222-333',
			'8533-4444','landres@hotmail.com',
			'Andres','Fernandez','Calderon','Alajuela','San Ramon','Piedades Sur','web developer','Em-000000');    


			               
select actualizarFuncionario('2015107073','0-000-000',
			'8533-4444','l5@hotmail.com',
			'c','c','c','c',
			'c','c','c');
			
select insertar_funcionario('2015107073','0-000-000','0000-0000',
                    'landresf12@hotmail.com','Andres ','Hernandez',
                    'Calderon','Alajuela','San Ramon','Piedades Sur','Profesor');
                    

select insertar_funcionario('2015107074','4-000-000','4000-0000',
                    'landresf3638@hotmail.com','Andres ','Hernandez',
                    'Calderon','Alajuela','San Ramon','Piedades Sur','Profesor');

select eliminarFuncionario('4-000-000');

select actualizarEstudiante('2015-110180','1-111-111',
			'8637-4844','landresf3638@hotmail.com',
			'Andres','adawda','Calderon','Alajuela',
			'San Ramon','Piedades Sur','Estudiante',1);

select p.cedula,p.nombre,p.apellido1,p.apellido2,p.provincia,p.canton,p.distrito,p.detalle,e.carnet,e.id_poliza from personas p inner join estudiantes e on e.cedula=p.cedula
insert into polizas(descripcion,monto,fecha_vencimiento,aseguradora)values('awdadw','5000','08-08-2018','INS'),
									('awdadw','10000','08-08-2018','INS'),
									('awdadw','15000','08-08-2018','INS');									
select insertar_Estudiante('2015-110180','2-122-193','8637-4844','landresf12@hotmail.com','Andres ','Hernandez',
'Calderon','Alajuela','San Ramon','Piedades Sur','Estudiante','1');
select insertar_Estudiante('2015-111111','2-321-321','8637-4845','landresf12@hotmail.com','Luis','Fernandez',
'Matamoros','Alajuela','San Ramon','Piedades Sur','Estudiante','2');
select insertar_Estudiante('2015-121212','2-745-217','8637-4846','landresf12@hotmail.com',
'Luis Andres','Fernandez','Calderon','Alajuela','San Ramon','Piedades Sur','Estudiante','3');   

select eliminarEstudiante('2-122-193');

drop function actualizarEstudiante()

select actualizarEstudiante('2222-222222','2-222-222',
			'8533-4444','l5@hotmail.com',
			'c','c','c','c',
			'c','c','c','1');


Select * from Personas


--Insertar Giras
create or replace function insertar_Giras(
	g_Fecha_inicio varchar(50),
	g_Fecha_final varchar(50),
	g_costo INT,
	g_duracion varchar(30),
	g_provincia VARCHAR(30) ,
	g_canton VARCHAR(30) ,
	g_distrito VARCHAR(30) ,
	g_detalle VARCHAR(100) 

)returns void as
$BODY$
Begin
	raise notice 'Insertando';
	insert into giras(Fecha_inicio,Fecha_final,costo,duracion,provincia,canton,distrito,detalle) values (cast (g_Fecha_inicio as date),cast(g_Fecha_final as date),g_costo,cast(g_duracion as time),g_provincia,g_canton,g_distrito,g_detalle);	
	
	raise notice 'Se inserto Gira';
end $BODY$
language plpgsql;

--funcion para trigger valida que la fecha final no ocurra antes que la de inicio
create or replace function validaInsercionGiras()
returns trigger as
$$
begin
	if (cast (NEW.fecha_final as date)<cast(NEW.fecha_inicio as date))then
		raise notice 'La fecha de finalización de la gira no puede estar antes que su inicio';
		delete from giras where new.id_gira=id_gira;
	end if;
	return new;
END
$$
language plpgsql
--trigger de validacion de fecha sobre giras
create trigger trigger_valida_Giras after insert ON giras
FOR EACH ROW EXECUTE PROCEDURE validaInsercionGiras();
----------Modificar giras-------------
--Modificar giras
CREATE OR REPLACE FUNCTION modificar_giras
(	
	g_ID_Gira int,
	g_Fecha_inicio varchar(50),
	g_Fecha_final varchar(50),
	g_costo INT,
	g_duracion varchar(30),
	g_provincia VARCHAR(30) ,
	g_canton VARCHAR(30) ,
	g_distrito VARCHAR(30) ,
	g_detalle VARCHAR(100) 

) RETURNS VOID
AS
$BODY$
BEGIN
    update giras set
	Fecha_inicio=cast(g_Fecha_inicio as date),
	Fecha_final=cast(g_Fecha_final as date),
	costo=g_costo,
	duracion=cast (g_duracion as time),
	provincia=g_provincia,
	canton=g_canton,
	distrito=g_distrito,
	detalle=g_detalle 

    where ID_gira=g_ID_Gira;
END;
$BODY$
LANGUAGE plpgsql;


--borrado de giras
CREATE OR REPLACE FUNCTION borrar_giras
(
	g_ID_Gira int
) RETURNS VOID
AS
$BODY$
BEGIN
    Delete from GE where id_gira=g_id_gira;
    delete from gs where id_gira=g_id_gira;
    delete from giras where id_gira=g_id_gira;
END;
$BODY$
LANGUAGE plpgsql;

--insertar giras funcionario´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´



--insertar giras y secciones
create or replace function insertar_Giras_secciones(
	idGira int,
	idSecciones char(10)
)returns void as
$BODY$
Begin
	raise notice 'Insertando gira con seccion';
	insert into SG values(idSecciones,idGira);	
	raise notice 'Se inserto Gira';
end $BODY$
language plpgsql;



/*select insertar_Giras_empresas(2,'07-03/2018');
select*from empresas
select*from giras
select*from SG
select insertar_secciones('07-03')
*/



--insertar gira empresa
create or replace function insertar_Giras_empresa(
	idGira int,
	idEmpresa char(9)
)returns void as
$BODY$
Begin
	raise notice 'Insertando gira con empresa';
	insert into GE values(idGira,idEmpresa);	
	raise notice 'Se inserto Gira';
end $BODY$
language plpgsql


/*select insertar_giras_empresa(2,'Em-000003');
select*from empresas
select*from giras
select*from SG
select insertar_secciones('07-03')
*/



--- Esta funcion sirve para editar las empresas de las giras esto se hace boorandolas de la tabla
--- Empresa Gira (GE)
CREATE OR REPLACE FUNCTION borrar_giras_empresas
(
	g_id_Gira int,
	g_id_empresa char(9)
) RETURNS VOID
AS
$BODY$
BEGIN
    Delete from GE where id_giras=g_id_gira and id_empresa=g_id_empresa;
    
END;
$BODY$
LANGUAGE plpgsql;


--- Esta funcion sirve para editar las secciones de las giras esto se hace boorandolas de la tabla
--- Giras secciones (GS)
CREATE OR REPLACE FUNCTION borrar_giras_secciones
(
	g_id_Gira int,
	g_id_seccion char(9)
) RETURNS VOID
AS
$BODY$
BEGIN
    Delete from GS where id_giras=g_id_gira and id_seccion=g_id_seccion;
    
END;
$BODY$
LANGUAGE plpgsql;

-----------------------------------------------------------------------------Falta crear gira funcionario y eliminar---------------------------------------------------------------------



--Tabla secciones
-------------------------SE DEBE MODIFICAR FUNCIONARIOS DE SER NECESARIO PARA LA NUEVA FORMA DE SECCIONES.------------------
CREATE TABLE Secciones(
	Id_secciones D_SECCIONES NOT NULL PRIMARY KEY
		      );

--- Insertar secciones
CREATE OR REPLACE function insertar_secciones
(
	s_id_seccion char(5)
)returns void as
$BODY$
Begin
	insert into secciones values (s_id_seccion || '/' ||extract(year from now()));
End;
$BODY$
Language plpgsql;



--ELIMINAR SECCIONES
CREATE or replace FUNCTION ELIMINAR_SECCIONES
(
	ID_ELIMINA_SECCION CHAR(10);
)RETURNS VOID AS
$BODY$
BEGIN
	DELETE FROM SECCIONES WHERE ID_ELIMINA_SECCION=ID_SECCIONES
end
$$


language plpgsql;
SELECT INSERTAR_SECCIONES('07-02')
select insertar_giras_secciones('2','Em-000000')
select insertar_giras_empresa('2','Em-000000')
select insertar_giras('2017-03-20','2017-04-01',1000000,'05:00:00','A la','Verga','Nos fuimos','Rayos')
select * from giras
select * from empresas
select * from GE
select * from SECCIONES
select borrar_giras_empresas(2,'Em-000000')

--cambiando el tipo de llave serial a domian de secciones
ALTER TABLE SG DROP CONSTRAINT fk_id_secciones_giras;
ALTER TABLE SF DROP CONSTRAINT fk_id_secciones_funcionarios_secciones;
ALTER TABLE ES DROP CONSTRAINT fk_id_secciones_ESTUDIANTES;
alter table secciones drop ID_SECCIONES;
ALTER TABLE SECCIONES ADD ID_SECCIONES D_SECCIONES;
ALTER TABLE SECCIONES ADD PRIMARY KEY(ID_SECCIONES);



--Consulta
/*Porcentaje de estudiantes que utilizan un tipo de póliza con respecto al total de estudiantes para cada póliza.*/
select p.monto,total.t_e*100/(select count(cedula) from estudiantes)||'%' from polizas p
	inner join
	(select id_poliza,count(cedula) as t_e from estudiantes
		group by(id_poliza)
	)as total on total.id_poliza=p.id_poliza;
	
select*from polizas 
select*from estudiantes
select * from personas

/*. Porcentaje de estudiantes que pertenecen a una provincia del país con respecto a todos los estudiantes, así para cada provincia.*/
select * from 
	(select count(provincia)*100/(select count(cedula) from estudiantes)as Porcentajes,
		count(cedulas)as Total_en_provincia,provincia,
		(select count(cedula)as "cedulas" from estudiantes)as"Total" from 
		
		(select e.cedula,count(e.cedula)as "cedulas" from estudiantes e
			group by(e.cedula)) as es

		inner join 
		(select provincia,cedula from personas) as pp

			on es.cedula=pp.cedula
		group by(provincia)
	
	)as t
	order by Total_en_provincia desc

select insertar_Estudiante('2015-110160','1-122-193','8637-4844','landresf12@hotmail.com','Andres ','Hernandez',
'Calderon','San Jose','San Ramon','Piedades Sur','Estudiante','1');

/*Promedio de aprobación de la práctica profesional por empresas filtrado entre el annos de finalizacion*/
--contar la cantidad de notas aprobadas y reprobadas en total, sacarlo por empresa,
select * from empresas
select * from practicas

select nombre,sum(nota)/count(p.id_empresa) as promedio ,p.id_empresa,fecha 
	from empresas e inner join 
		(select fecha_final as fecha,nota,p.id_empresa from practicas p)as p
		
	on p.id_empresa=e.id_empresa 
	group by (p.id_empresa,nombre,fecha)
	order by (promedio) desc


insert into practicas(Fecha_inicio,Fecha_final,nota,estado,cedula,ID_Empresa) values('10-10-2017','10-10-2018',40,'a','1-122-193','Em-000001');
select insertar_empresa('Em-000002','Avantica','Alajuela','San Carlos','Quesada','lol','8888-9999','ava@ava.ava')


/*Porcentaje de Giras realizadas a una empresa en el año x con respecto a todas las giras realizadas en el mismo año y el funcionario que ha tenido mayor participación.*/
--Hablar sobre esto

select * from eventos
select * from ef

/* Agregar a las empresas el número de estudiantes que realizan práctica en ella durante el año actual*/



