<?php
if(function_exists($_REQUEST['Funcion'])){
    $_REQUEST['Funcion']();
}
else
{
    echo 'La funcion no ha sido creada: Comuniquese';
}

function ObtenertodosCoorporations(){
		//se importa la conexion con la base de datos
		include("../conexion.php");
		//se declara el query
		$query="select E.id_empresa,E.nombre,E.provincia, E.canton, E.distrito,E.detalle, T.telefono,C.correo from empresas E inner join telefonos_e T on  E.id_empresa = T.id_empresa
			inner join correos_E C on E.id_empresa=C.id_empresa;";
		
		//pg_query se encarga de ejecutar el query mediante la conexion y el query y  se encarga de realizar la consulta a la base y generar una tabla
		$result=pg_query($con,$query)or die("Error de consulta");
		//se cierra la conexion ya que los datos se guardaron en la variable $result
		pg_close($con);
		//pg_fetch_all se encarga de retornar un array con filas y columnas de la tabla que se creo con el query
		$respuesta=pg_fetch_all($result);
		// json_encode se encarga de convertir el array en un json(java script object notation)
		echo json_encode($respuesta);
}
function putEmpresas(){
		//se importa la conexion con la base de datos
		include("../conexion.php");
		//decodifica un string a json 
	    $obj = json_decode(file_get_contents("php://input"));
	    //query de la consulta a la base de datos
	    $query = "select insertar_empresa('$obj->id_empresa','$obj->nombre',"
	            . "'$obj->provincia','$obj->canton','$obj->distrito',"
	            . "'$obj->detalle','$obj->telefono','$obj->correo');";
	    //pg_query se encarga de ejecutar el query mediante la conexion y el query y  se encarga de realizar la consulta a la base y generar una tabla
	    $result = pg_query($con,$query) or die ("'estado': 1");
	    
	    //pg_fetch_all se encarga de retornar un array con filas y columnas de la tabla que se creo con el query
	    $respuesta = json_encode($result);
	    //se cierra la conexion ya que los datos se guardaron en la variable $result
	    pg_close($con);
	    
	    echo $respuesta;  
}

function deleteEmpresas(){
		//se importa la conexion con la base de datos
		include("../conexion.php");
		//decodifica un string a json 
	    $obj = json_decode(file_get_contents("php://input"));
	    //query de la consulta a la base de datos
	    $query = "select borrar_empresa('$obj->ida');";
	    //pg_query se encarga de ejecutar el query mediante la conexion y el query y  se encarga de realizar la consulta a la base y generar una tabla
	    $result = pg_query($con,$query) or die ("'estado': 1");
	    
	    //pg_fetch_all se encarga de retornar un array con filas y columnas de la tabla que se creo con el query
	    $respuesta = json_encode($result);
	    //se cierra la conexion ya que los datos se guardaron en la variable $result
	    pg_close($con);
	    
	    echo $respuesta;  
}
function updateEmpresas(){
		//se importa la conexion con la base de datos
		include("../conexion.php");
		//decodifica un string a json 
	    $obj = json_decode(file_get_contents("php://input"));
	    //query de la consulta a la base de datos
	    $query = "select modificar_empresa('$obj->id_empresa','$obj->nombre',"
	            . "'$obj->provincia','$obj->canton','$obj->distrito',"
	            . "'$obj->detalle','$obj->telefono','$obj->correo');";
	    //pg_query se encarga de ejecutar el query mediante la conexion y el query y  se encarga de realizar la consulta a la base y generar una tabla
	    $result = pg_query($con,$query) or die ("'estado': 1");
	    
	    //pg_fetch_all se encarga de retornar un array con filas y columnas de la tabla que se creo con el query
	    $respuesta = json_encode($result);
	    //se cierra la conexion ya que los datos se guardaron en la variable $result
	    pg_close($con);
	    
	    echo $respuesta;  
}

?>