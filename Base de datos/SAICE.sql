
-----------Dominios SAICE----------
(
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

CREATE DOMAIN id_evento CHAR(9) NOT NULL CONSTRAINT CHK_id_evento 
CHECK (VALUE SIMILAR TO 'Ev-[0-9][0-9][0-9][0-9][0-9][0-9]');

CREATE DOMAIN d_secciones CHAR(10) NOT NULL CONSTRAINT CHK_id_secciones 
CHECK (VALUE SIMILAR TO '[0-9][0-9]-[0-9][0-9]/[0-9][0-9][0-9][0-9]');

CREATE DOMAIN id_practica CHAR(9) NOT NULL CONSTRAINT CHK_id_practica
CHECK (VALUE SIMILAR TO 'Pr-[0-9][0-9][0-9][0-9][0-9][0-9]');
)

----------Tablas SEICE----------
(
----Tabla Secciones
CREATE TABLE Secciones(
	Id_secciones D_SECCIONES NOT NULL PRIMARY KEY
		      );

--Tabla eventos
 CREATE TABLE Eventos(
	ID_Evento id_evento primary key NOT NULL,
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
	ID_Evento id_evento NOT NULL,
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
	ID_Poliza serial NOT NULL PRIMARY KEY,
	Descripcion VARCHAR(100) NULL,
	Monto INT NOT NULL,
	Fecha_vencimiento DATE NOT NULL,
	Aseguradora VARCHAR(30) NOT NULL
                    );
--Tabla estudiantes
CREATE  TABLE Estudiantes(
	cedula a_cedula PRIMARY KEY,
	carnet a_carnet,
	ID_Poliza id_poliza NOT NULL,
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
		ID_Practicas id_practica NOT NULL PRIMARY KEY,
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
)




-----------------------------------------Funciones agregar----------------------------------------------------------------
--------------------------------------------------------CRUD de estudiantes-----------------------------------------------
(--Agregar Estudiantes falta al insertar que lleve conexion de polizas
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
			delete from practicas where cedula=p_cedula;
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
)
		
--------------------------------------------------------CRUD de funcionarios------------------------------------------------------------------
(
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

)
----------------------------------------------------------CRUD Contactos---------------------------------
(
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

)
--- -------------------------------------------------------CRUD practicas-----------------------------------------------
(
create or replace function insertar_Practica(
	p_id_practica id_practica,
	p_fecha_inicio varchar(8),
	p_fecha_final varchar(8),
	p_cedula a_cedula,
	p_id_empresa id_empresa
)returns void as
$BODY$
Begin
	raise notice 'Insertando';
	insert into practicas values (p_id_practica,cast(p_fecha_inicio as date),cast(p_fecha_final as date),0,'r',p_cedula,p_id_empresa);	
	raise notice 'Se inserto Estudiante';
end $BODY$
language plpgsql;

---------- borrar practica---------------------
create or replace function borrar_practica( 
	p_id_practica id_practica
) returns void as
$BODY$
begin
	delete from practicas where id_practicas=p_id_practica;
	raise notice 'practica borrada';
end
$BODY$
language plpgsql;

-------------- modificar practica------
create or replace function modificar_Practica(
	p_id_practica id_practica,
	p_fecha_inicio varchar(10),
	p_fecha_final varchar(10),
	p_nota integer,
	p_cedula a_cedula,
	p_id_empresa id_empresa
)returns void as
$BODY$
	declare p_estado CHAR(1);
Begin
	if(p_nota>=70) then 
		p_estado='a';
	elseif(p_nota<70)then 
		p_estado='r';
	end if;
	update practicas set
		id_practicas=p_id_practica,
		fecha_inicio=cast (p_fecha_inicio as date),
		fecha_final=cast(p_fecha_final as date),
		nota=p_nota,
		estado=p_estado,
		cedula=p_cedula,
		id_empresa=p_id_empresa
	where id_practicas=p_id_practica;	
	raise notice 'Se modifico Practica';
end $BODY$
language plpgsql;

--obtener practicas
select ES.nombre, ES.apellido1, ES.apellido2, ES.carnet, PR.cedula,PR.id_practicas,PR.nota, PR.nombre,PR.fecha_inicio,PR.fecha_final from 
	(select P.nombre, P.apellido1, P.apellido2, P.cedula, E.carnet 
	from personas P inner join estudiantes E on P.cedula=E.cedula) as ES
inner join 
	(select P.cedula,P.id_practicas,E.nombre,P.nota,P.fecha_inicio,P.fecha_final
	from practicas P inner join empresas E on P.id_empresa = E.id_empresa) as PR
on ES.cedula=PR.cedula
)







-----------------------------------------------------------CRUD Polizas-----------------------------------------------
(--Insertar Polizas
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
)

------------------------------------------------------------CRUD Secciones----------------------------
(
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
)
------------------------------------------------------ Un par de consultas
(
---Filtro de estudiante
select p.cedula,p.nombre,p.apellido1,p.apellido2,p.provincia,
				p.canton,p.distrito,p.detalle,e.carnet,e.id_poliza,t.telefono,cp.correo from personas
				p inner join estudiantes e on e.cedula='1-123-123'and p.cedula='1-123-123' inner join 
				correos_p cp on cp.cedula='1-123-123' inner join telefonos_p t on t.cedula='1-123-123';


update practicas set estado='a' where id_practicas='Pr-000002';

select modificar_Practica('Pr-000002','21-04-2018','21-08-2018',70,'2-745-217','Em-000000');
select * from practicas


select * from practicas
--pruebas crod practicas
select insertar_Practica('Pr-000000','20-03-2017','20-06-2017','2-222-222','Em-000000');
select insertar_Practica('Pr-000001','20-03-2017','20-06-2017','2-222-222','Em-000000');
select insertar_Practica('Pr-000002','20-03-2017','20-06-2017','2-222-222','Em-000000'); -- ya funcuiona
select insertar_empresa('Em-000000','GBS','Alajuela','San Carlos','Quesada','lol XD','8888-8888','gbs@lol.com')
select insertar_Evento('Ev-000000','cena','cena residencia','25-06-2017','26-06-2017','1-111-111','Trabajad');--


select modificar_Practica('Pr-000002','21-04-2018','21-07-2018',90,'a','2-222-222','Em-000000'); --ya funciona
select modificar_empresa('Em-000000','GBS','Alajuela','San Carlos','Quesada','lol XD','8888-8888','gbs@lol.com')
select modificar_evento('Ev-000000','Comelona','cena residencia','25-06-2017','26-06-2017','1-111-111','web');--funciona


select borrar_empresa('Em-000000');
select borrar_practica('Pr-000001');-- 
select borrar_evento('Ev-000000');--funciona
funciona

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



select modificar_Practica('Pr-000002','21-04-2018','21-07-2018',70,'2-745-217','Em-000000');
select * from practicas

select eliminarEstudiante('2-745-217');

drop function actualizarEstudiante()

select actualizarEstudiante('2222-222222','2-222-222',
			'8533-4444','l5@hotmail.com',
			'c','c','c','c',
			'c','c','c','1');

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





Select * from Personas
select cursor_polizas();
select * from polizas;
select * from estudiantes


alter table polizas add column num_estudiantes bigint

)

----------------------------------------------------------CRUD empresas----------------------------------------------------------------------
(--Agregar empresa

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


--borrar empresa
create or replace function borrar_empresa( 
	p_id_empresa id_empresa
) returns void as
$BODY$
begin
	delete from telefonos_E where id_empresa=p_id_empresa;
	delete from correos_E where id_empresa=p_id_empresa;
	delete from ce where id_empresa=p_id_empresa;
	delete from empresas where id_empresa=p_id_empresa;
	raise notice 'empresa borrada';
end
$BODY$
language plpgsql;

-- modificar empresa
create or replace function modificar_empresa(
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
	update Empresas set
		nombre=e_nombre,
		provincia=e_provincia,
		canton=e_canton,
		distrito=e_distrito,
		detalle=e_detalle where id_empresa=e_id_empresa;
	update Telefonos_E set telefono = e_telefono where id_empresa=e_id_empresa;
	update Correos_E set correo = e_correos where id_empresa=e_id_empresa;
	raise notice 'Se modifico la empresa' ;
end $BODY$
language plpgsql;

--obtener empresa

select E.id_empresa,E.nombre,E.provincia, E.canton, E.distrito,E.detalle, T.telefono,C.correo from empresas E inner join telefonos_e T on  E.id_empresa = T.id_empresa
inner join correos_E C on E.id_empresa=C.id_empresa;
)


----------------------------------------------------------CRUD eventos------------------------------------------------------------------
(
create or replace function insertar_Evento( -- funcion creada
	p_id_evento id_evento,
	p_nombre varchar(30),
	p_descripcion varchar(100),
	p_fecha_inicio date,
	p_fecha_final date,
	p_cedula_funcionario varchar(9),
	p_rol_funcionario varchar(30)
)returns void as
$BODY$
Begin
	raise notice 'Insertando';
	insert into eventos values (p_id_evento,p_nombre,p_descripcion,p_fecha_inicio,p_fecha_final);
	insert into EF values (p_cedula_funcionario,p_id_evento,p_rol_funcionario);
	
	raise notice 'Se inserto evento';
end $BODY$
language plpgsql;

--borrar evento
create or replace function borrar_evento
(
	p_id_evento id_evento
)returns void as
$BODY$
begin
	delete from EF      where id_evento = p_id_evento;
	delete from eventos where id_evento = p_id_evento;
end 
$BODY$ 
language plpgsql;

-- modificar eventos
CREATE OR REPLACE FUNCTION modificar_Evento
(
	p_id_evento id_evento,
	p_nombre varchar(30),
	p_descripcion varchar(100),
	p_fecha_inicio date,
	p_fecha_final date,
	p_cedula_funcionario varchar(9),
	p_rol_funcionario varchar(30)
) returns void as
$BODY$ begin
	update eventos set
		id_evento=p_id_evento,
		nombre=p_nombre,
		descripcion=p_descripcion,
		fechainicio=p_fecha_inicio,
		fechafinal=p_fecha_final
		where id_evento=p_id_evento;
	update EF set 
		cedula=p_cedula_funcionario,
		id_evento=p_id_evento,
		rol=p_rol_funcionario
		where id_evento=p_id_evento;
	
	raise notice 'se modifico evento';
end $BODY$
language plpgsql;

--obtener evento

select EV.nombre,EV.fechainicio,EV.fechafinal, EV.rol,PE.cedula, PE.nombre, PE.apellido1 from 
(select F.cedula,E.nombre,E.fechainicio,E.fechafinal, F.rol from eventos E inner join EF  F on E.id_evento= F.id_evento) as EV
inner join
(select F.cedula, P.nombre, P.apellido1 from funcionarios F inner join personas P on F.cedula=P.cedula) as PE
on EV.cedula=PE.cedula;
)





----------------------------------------------------------CRUD Giras---------------------------------------------------------------
(
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


---------------------------------------------------------------borrado de giras
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



-------------------------------------------------------------insertar giras y secciones
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


-------------------------------------------------------------------------- Giras secciones (GS)-----------------------------
--- Esta funcion sirve para editar las secciones de las giras esto se hace boorandolas de la tabla
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


)

---------------------------------------------------------Triggers-------------------------------------------------------------
(--Falta validar fecha eventos y practicas
--funcion para trigger valida que la fecha final no ocurra antes que la de inicio
create or replace function validaInsercionGiras()
returns trigger as
$$
begin
	if (cast (NEW.fecha_final as date)<cast(NEW.fecha_inicio as date))then
		delete from giras where new.id_gira=id_gira;
		raise notice 'La fecha de finalización de la gira no puede estar antes que su inicio';
	end if;
	return new;
END
$$
language plpgsql
--trigger de validacion de fecha sobre giras
create trigger trigger_valida_Giras after insert ON giras
FOR EACH ROW EXECUTE PROCEDURE validaInsercionGiras();

----------funcion que se encarga de validar cuando se elimina un estudiante
create or replace function validaEliminacionEstudiante()
returns trigger as
$$
begin
	if (OLD.estado='a')then
		insert into practicas values (OLD.id_practicas,OLD.fecha_inicio,OLD.fecha_final,OLD.nota,OLD.estado,OLD.cedula,OLD.id_empresa);
		raise notice 'El estudiante es un egresado por lo tanto no se puede eliminar';
	end if;
	return new;
END
$$
language plpgsql

--trigger de validacion de eliminacion de estudiantes
create trigger trigger_valida_Estudiantes after delete ON practicas
FOR EACH ROW EXECUTE PROCEDURE validaEliminacionEstudiante();
)


----------------------------------------CURSORES-----------------------
(--CURSOR_POLIZAS------------
create or replace function cursor_polizas()
returns void as
$$
declare
	cursor_polizas CURSOR for
		select distinct id_poliza  from 
		polizas;
	v_id char(9);
begin
	open cursor_polizas;
	fetch next  from cursor_polizas into v_id;
	while (found) loop
		raise notice 'Registro: %', v_id;
		update polizas
		set num_estudiantes=(select P.cantidad from
		(select count(E.cedula) cantidad , E.id_poliza
		from estudiantes  E inner join polizas P on E.id_poliza=P.id_poliza
		group by E.id_poliza) as P where P.id_poliza=v_id 
		)
		where id_poliza=v_id;
		fetch next  from cursor_polizas into v_id;
	end loop;
end;
$$
language plpgsql;
)
-----------------------------------------------------FIN CURSORES--------------------------



(/*1. Sacar el promedio de aprobacion de practicas de un año
con respecto a la cantidad de practicas, la mejor nota 
y la peor.*/

-- la consulta se hace mediante una funcion para poder indicarle el año
--la tabla guarda el resultado de la consulta
create table promedio_practicas
(
	promedio bigint,
	mejor_nota int,
	peor_nota int
);

CREATE OR REPLACE FUNCTION Calcular_Promedio_Practicas(año int)
returns void as
$BODY$
begin
	insert into promedio_practicas  
	(select * from
(select distinct
(select count(id_practicas) as aprobadas from practicas where extract(year from fecha_inicio)=año and nota>=70)*100/
(select count(id_practicas) as cant from practicas where extract(year from fecha_inicio)=año) "promedio en %"  from practicas ) as PR
cross join 
(select nota as "Mejor nota" from practicas where extract(year from fecha_inicio)=año order by nota desc limit 1) as M
cross join
(select nota as "Peor nota" from practicas where extract(year from fecha_inicio)=año order by nota asc limit 1) as P);
end;
$BODY$ language plpgsql;

select Calcular_Promedio_Practicas(2017);
select * from promedio_practicas;
)
(/*2. Sacar el promedio de estudiantes que obtuvieron 
una nota entre 0 y 70, 70 y 80, 80 y 90,90 y 100 con respecto
a la cantidad de practicas.*/
select 
((select count(id_practicas) as nota from practicas  where nota <= 70)*100/
(select count(id_practicas) as cant from practicas)) as "promedio <= 70",
((select count(id_practicas) as nota from practicas  where nota >70 and nota <= 80)*100/
(select count(id_practicas) as cant from practicas)) as ">70 <=80",
((select count(id_practicas) as nota from practicas  where nota >80 and nota <= 90)*100/
(select count(id_practicas) as cant from practicas)) as ">80 <=90",
((select count(id_practicas) as nota from practicas  where nota >90 and nota <= 100)*100/
(select count(id_practicas) as cant from practicas)) as ">70 <=80";
 --from practicas limit 1
)



(/*3Porcentaje de estudiantes que utilizan un tipo de póliza con respecto
al total de estudiantes para cada póliza.*/
select p.monto,total.t_e*100/(select count(cedula) from estudiantes)||'%' from polizas p
	inner join
	(select id_poliza,count(cedula) as t_e from estudiantes
		group by(id_poliza)
	)as total on total.id_poliza=p.id_poliza;
	
select*from polizas 
select*from estudiantes
select * from personas
)


(/*4. Porcentaje de estudiantes que pertenecen a una provincia del país con respecto a todos los estudiantes, así para cada provincia.*/
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
)
(/*5Promedio de aprobación de la práctica profesional por empresas filtrado entre el años de finalizacion*/
select nombre,sum(nota)/count(p.id_empresa) as promedio ,p.id_empresa,fecha 
	from empresas e inner join 
		(select fecha_final as fecha,nota,p.id_empresa from practicas p)as p
		
	on p.id_empresa=e.id_empresa 
	group by (p.id_empresa,nombre,fecha)
	order by (promedio) desc

select * from practicas
insert into practicas values('Pr-000003','10-10-2017','10-10-2018',100,'a','1-122-193','Em-000001');
select insertar_empresa('Em-000002','Avantica','Alajuela','San Carlos','Quesada','lol','8888-9999','ava@ava.ava')
)

(/*6. top 3 Cantones con más egresados en dado año  #### FALTA PONERLE EL AÑO*/

select count(P.id_practicas) cantidad_practicas,E.canton from
(select E.cedula,P.canton from estudiantes E inner join  personas P on E.cedula=P.cedula) E 
inner join practicas  P on P.cedula=E.cedula and extract(year from P.fecha_final)=2017 and P.nota >=70
group by canton 
order by cantidad_practicas desc 
limit 3;)
(/* 7. Empresas con indice de aprobacion de prácticas más alto*/
select E.nombre,P.* from 
(select nombre,id_empresa from empresas)as E 
inner join
(select A.id_empresa,A.Cantidad_participantes,B.numero_aprobados,((Numero_aprobados)*100/(Cantidad_participantes)) porcentaje_aprobacion from (
select count(id_practicas) Cantidad_participantes,id_empresa  from practicas group by id_empresa) as A inner join
(select count(id_practicas)Numero_aprobados, id_empresa from practicas where nota >=70 group by id_empresa) as B
on A.id_empresa = B.id_empresa  order by porcentaje_aprobacion desc) as P
on p.id_empresa=E.id_empresa;
)



/*select insertar_Giras_empresas(2,'07-03/2018');
select*from empresas
select*from giras
select*from SG
select insertar_secciones('07-03')
*/

--insertar giras funcionario´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´
/*select insertar_giras_empresa(2,'Em-000000');
/*select insertar_giras_empresa(2,'Em-000003');
select*from empresas
select*from giras
select*from SG
select insertar_secciones('07-03')
*/


--eliminar funcionario seccion e insertar funcionario seccion'''''''''''''''''''''''''''''''''''''''''''''
/*Porcentaje de Giras realizadas a una empresa en el año x con respecto a todas las giras realizadas en el mismo año y el funcionario que ha tenido mayor participación.*/
--Hablar sobre esto
