<?php
if(function_exists($_REQUEST['Funcion'])){
    $_REQUEST['Funcion']();
}
else
{
    echo 'La funcion no ha sido creada: Comuniquese';
}

function ObtenertodosEvents(){
		//se importa la conexion con la base de datos
		include("../conexion.php");
		//se declara el query
		$query="select EV.nombre,EV.fechainicio,EV.fechafinal, EV.rol,PE.cedula, PE.nombre||' '||PE.apellido1||'  '||PE.apellido2"." ". "nombre_completo,"."EV.id_evento,EV.descripcion from 
				(select F.cedula,E.id_evento,E.nombre,E.fechainicio,E.fechafinal,E.descripcion, F.rol from eventos E inner join EF  F on E.id_evento= F.id_evento) as EV
				inner join
				(select F.cedula, P.nombre, P.apellido1,P.apellido2 from funcionarios F inner join personas P on F.cedula=P.cedula) as PE
				on EV.cedula=PE.cedula;";
		
		//pg_query se encarga de ejecutar el query mediante la conexion y el query y  se encarga de realizar la consulta a la base y generar una tabla
		$result=pg_query($con,$query)or die("Error de consulta");
		//se cierra la conexion ya que los datos se guardaron en la variable $result
		pg_close($con);
		//pg_fetch_all se encarga de retornar un array con filas y columnas de la tabla que se creo con el query
		$respuesta=pg_fetch_all($result);
		// json_encode se encarga de convertir el array en un json(java script object notation)
		echo json_encode($respuesta);
}
function putEventos(){
		//se importa la conexion con la base de datos
		include("../conexion.php");
		//decodifica un string a json 
	    $obj = json_decode(file_get_contents("php://input"));
	    //query de la consulta a la base de datos
	    $query = "select insertar_Evento('$obj->id_evento','$obj->nombre',"
	            . "'$obj->descripcion','$obj->fechainicio','$obj->fechafinal',"
	            . "'$obj->cedula','$obj->rol');";
	    //pg_query se encarga de ejecutar el query mediante la conexion y el query y  se encarga de realizar la consulta a la base y generar una tabla
	    $result = pg_query($con,$query) or die ("'estado': 1");
	    
	    //pg_fetch_all se encarga de retornar un array con filas y columnas de la tabla que se creo con el query
	    $respuesta = json_encode($result);
	    //se cierra la conexion ya que los datos se guardaron en la variable $result
	    pg_close($con);
	    
	    echo $respuesta;  
}

function deleteEventos(){
		//se importa la conexion con la base de datos
		include("../conexion.php");
		//decodifica un string a json 
	    $obj = json_decode(file_get_contents("php://input"));
	    //query de la consulta a la base de datos
	    $query = "select borrar_evento('$obj->ida');";
	    //pg_query se encarga de ejecutar el query mediante la conexion y el query y  se encarga de realizar la consulta a la base y generar una tabla
	    $result = pg_query($con,$query) or die ("'estado': 1");
	    
	    //pg_fetch_all se encarga de retornar un array con filas y columnas de la tabla que se creo con el query
	    $respuesta = json_encode($result);
	    //se cierra la conexion ya que los datos se guardaron en la variable $result
	    pg_close($con);
	    
	    echo $respuesta;  
}
function updateEventos(){
		//se importa la conexion con la base de datos
		include("../conexion.php");
		//decodifica un string a json 
	    $obj = json_decode(file_get_contents("php://input"));
	    //query de la consulta a la base de datos
	    $query = "select modificar_Evento('$obj->id_evento','$obj->nombre',"
	            . "'$obj->descripcion','$obj->fechainicio','$obj->fechafinal',"
	            . "'$obj->cedula','$obj->rol');";
	    //pg_query se encarga de ejecutar el query mediante la conexion y el query y  se encarga de realizar la consulta a la base y generar una tabla
	    $result = pg_query($con,$query) or die ("'estado': 1");
	    
	    //pg_fetch_all se encarga de retornar un array con filas y columnas de la tabla que se creo con el query
	    $respuesta = json_encode($result);
	    //se cierra la conexion ya que los datos se guardaron en la variable $result
	    pg_close($con);
	    
	    echo $respuesta;  
}

?>
