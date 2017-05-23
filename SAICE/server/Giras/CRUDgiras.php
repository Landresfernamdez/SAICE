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
?>