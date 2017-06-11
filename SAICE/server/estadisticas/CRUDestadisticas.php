<?php
if(function_exists($_REQUEST['Funcion'])){
    $_REQUEST['Funcion']();
}
else
{
    echo 'La funcion no ha sido creada: Comuniquese';
}

function ObtenerSPorcentageEPoliza(){
		//se importa la conexion con la base de datos
		include("../conexion.php");
		//se declara el query
		$query="select p.monto,p.id_poliza,total.t_e*100/(select count(cedula) from estudiantes)porcentage,total.t_e  total from polizas p
			inner join
		(select id_poliza,count(cedula) as t_e from estudiantes
		group by(id_poliza)
	)as total on total.id_poliza=p.id_poliza;";
		//pg_query se encarga de ejecutar el query mediante la conexion y el query y  se encarga de realizar la consulta a la base y generar una tabla
		$result=pg_query($con,$query)or die("Error de consulta");
		//se cierra la conexion ya que los datos se guardaron en la variable $result
		pg_close($con);
		//pg_fetch_all se encarga de retornar un array con filas y columnas de la tabla que se creo con el query
		$respuesta=pg_fetch_all($result);
		// json_encode se encarga de convertir el array en un json(java script object notation)
		echo json_encode($respuesta);
}
function ObtenerSPromedioEXprovincia(){
		//se importa la conexion con la base de datos
		include("../conexion.php");
		//se declara el query
		$query="select * from 
	(select count(provincia)*100/(select count(cedula) from estudiantes)as Porcentajes,
		count(cedulas)as Total_en_provincia,provincia,
		(select count(cedula)as cedulas from estudiantes)as Total  from 
		
		(select e.cedula,count(e.cedula)as cedulas from estudiantes e
			group by(e.cedula)) as es

		inner join 
		(select provincia,cedula from personas) as pp

			on es.cedula=pp.cedula
		group by(provincia)
	
	)as t
	order by Total_en_provincia desc;";
		//pg_query se encarga de ejecutar el query mediante la conexion y el query y  se encarga de realizar la consulta a la base y generar una tabla
		$result=pg_query($con,$query)or die("Error de consulta");
		//se cierra la conexion ya que los datos se guardaron en la variable $result
		pg_close($con);
		//pg_fetch_all se encarga de retornar un array con filas y columnas de la tabla que se creo con el query
		$respuesta=pg_fetch_all($result);
		// json_encode se encarga de convertir el array en un json(java script object notation)
		echo json_encode($respuesta);
}
function ObtenerSPromedioNotas(){
    //se importa la conexion con la base de datos
    include("../conexion.php");
    //se declara el query
    $query="select * from promediodeconcurrencianotas";
    //pg_query se encarga de ejecutar el query mediante la conexion y el query y  se encarga de realizar la consulta a la base y generar una tabla
    $result=pg_query($con,$query)or die("Error de consulta");
    //se cierra la conexion ya que los datos se guardaron en la variable $result
    pg_close($con);
    //pg_fetch_all se encarga de retornar un array con filas y columnas de la tabla que se creo con el query
    $respuesta=pg_fetch_all($result);
    // json_encode se encarga de convertir el array en un json(java script object notation)
    echo json_encode($respuesta);
}
?>