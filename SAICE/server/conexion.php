
<?php 
//pg_connect() permite la conexion con la base de datos
$con=pg_connect("host=localhost port=5432 dbname=SAICE user=postgres password=12345") or die("error de conexion");
?>