<?php
if(function_exists($_REQUEST['Funcion'])){
    $_REQUEST['Funcion']();
}
else
{
    echo 'La funcion no ha sido creada: Comuniquese';
}

function getTours(){
		//database settings
		include("../conexion.php");

		$query="select * from giras";
		

		$result=pg_query($con,$query)or die("Error de consulta");
		
		$x=0;

		pg_close($con);
		$respuesta=pg_fetch_all($result);
		echo json_encode($respuesta);
}
function putTours(){
		//se importa la conexion con la base de datos
		include("../conexion.php");
		//decodifica un string a json 
	    $obj = json_decode(file_get_contents("php://input"));
	    //query de la consulta a la base de datos
	    $query = "select insertar_giras('$obj->Fecha_inicio','$obj->Fecha_final',"
	            . "'$obj->costo','$obj->duracion','$obj->provincia',"
	            . "'$obj->canton','$obj->distrito','$obj->provincia',"
	            . "'$obj->canton','$obj->distrito','$obj->detalle');";

	           
	    //pg_query se encarga de ejecutar el query mediante la conexion y el query y  se encarga de realizar la consulta a la base y generar una tabla
	    $result = pg_query($con,$query) or die ("'estado': 1");
	    
	    //pg_fetch_all se encarga de retornar un array con filas y columnas de la tabla que se creo con el query
	    $respuesta = json_encode($result);
	    //se cierra la conexion ya que los datos se guardaron en la variable $result
	    pg_close($con);
	    
	    echo $respuesta;  
}


?>