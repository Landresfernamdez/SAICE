<?php
if(function_exists($_REQUEST['Funcion'])){
    $_REQUEST['Funcion']();
}
else
{
    echo 'La funcion no ha sido creada: Comuniquese';
}

function ObtenertodosContactos(){
		//se importa la conexion con la base de datos
		include("../conexion.php");
		//se declara el query
		$query="select p.cedula,p.nombre,p.apellido1,p.apellido2,p.provincia,
				p.canton,p.distrito,p.detalle,t.telefono,cp.correo,c.puesto,r.ID_empresa from personas
				p inner join contactos c on c.cedula=p.cedula inner join 
				correos_p cp on cp.cedula=p.cedula inner join telefonos_p t on t.cedula=p.cedula  inner join ce
				r on r.cedula=p.cedula;";
		
		//pg_query se encarga de ejecutar el query mediante la conexion y el query y  se encarga de realizar la consulta a la base y generar una tabla
		$result=pg_query($con,$query)or die("Error de consulta");
		//se cierra la conexion ya que los datos se guardaron en la variable $result
		pg_close($con);
		//pg_fetch_all se encarga de retornar un array con filas y columnas de la tabla que se creo con el query
		$respuesta=pg_fetch_all($result);
		// json_encode se encarga de convertir el array en un json(java script object notation)
		echo json_encode($respuesta);
}
function putContactos(){
		//se importa la conexion con la base de datos
		include("../conexion.php");
		//decodifica un string a json 
	    $obj = json_decode(file_get_contents("php://input"));
	    //query de la consulta a la base de datos
	    $query = "select insertar_contacto('$obj->puesto','$obj->cedula',"
	            . "'$obj->telefono','$obj->correo','$obj->nombre',"
	            . "'$obj->apellido1','$obj->apellido2','$obj->provincia',"
	            . "'$obj->canton','$obj->distrito','$obj->detalle','$obj->id_empresa');";
	    //pg_query se encarga de ejecutar el query mediante la conexion y el query y  se encarga de realizar la consulta a la base y generar una tabla
	    $result = pg_query($con,$query) or die ("'estado': 1");
	    
	    //pg_fetch_all se encarga de retornar un array con filas y columnas de la tabla que se creo con el query
	    $respuesta = json_encode($result);
	    //se cierra la conexion ya que los datos se guardaron en la variable $result
	    pg_close($con);
	    
	    echo $respuesta;  
}

function deleteContactos(){
		//se importa la conexion con la base de datos
		include("../conexion.php");
		//decodifica un string a json 
	    $obj = json_decode(file_get_contents("php://input"));
	    //query de la consulta a la base de datos
	    $query = "select eliminarContacto('$obj->ida');";
	    //pg_query se encarga de ejecutar el query mediante la conexion y el query y  se encarga de realizar la consulta a la base y generar una tabla
	    $result = pg_query($con,$query) or die ("'estado': 1");
	    
	    //pg_fetch_all se encarga de retornar un array con filas y columnas de la tabla que se creo con el query
	    $respuesta = json_encode($result);
	    //se cierra la conexion ya que los datos se guardaron en la variable $result
	    pg_close($con);
	    
	    echo $respuesta;  
}
function updateContactos(){
		//se importa la conexion con la base de datos
		include("../conexion.php");
		//decodifica un string a json 
	    $obj = json_decode(file_get_contents("php://input"));
	    //query de la consulta a la base de datos
	    $query = "select actualizarContacto('$obj->puesto','$obj->cedula',"
	            . "'$obj->telefono','$obj->correo','$obj->nombre',"
	            . "'$obj->apellido1','$obj->apellido2','$obj->provincia',"
	            . "'$obj->canton','$obj->distrito','$obj->detalle','$obj->id_empresa');";
	    //pg_query se encarga de ejecutar el query mediante la conexion y el query y  se encarga de realizar la consulta a la base y generar una tabla
	    $result = pg_query($con,$query) or die ("'estado': 1");
	    
	    //pg_fetch_all se encarga de retornar un array con filas y columnas de la tabla que se creo con el query
	    $respuesta = json_encode($result);
	    //se cierra la conexion ya que los datos se guardaron en la variable $result
	    pg_close($con);
	    
	    echo $respuesta;  
}
?>