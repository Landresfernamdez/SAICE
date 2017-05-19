'use strict'
angular.module('userModule')
.controller('estudiantesController',function($scope,OperationsStudents,$location,$route){

	$scope.listaStudents = [];
	$scope.estudiante = {
		carnet:"",
		cedula:"",
		telefono:"",
		correo:"",
		nombre:"",
		apellido1:"",
		apellido2:"",
		provincia:"",
		canton:"",
		distrito:"",
		detalle:"",
		id_poliza:""
	};
	console.log("entro a comprobacion");
	
	$scope.getEstudiantes = function getEstudiantes() {

		OperationsStudents.getStudents( function(res) {
			$scope.listaStudents = res;
		});

	};
	$scope.getEstudiantes();

	$scope.putEstudiante = function putEstudiante(estudiante) {

		OperationsStudents.putStudents($scope.estudiante, function(response) {

			if (response.success) {
				console.log("exito");
				//$scope.listaStudents.push(estudiante);
			    $location.path('estudiantes');
			    $route.reload();
			}

		});
	};
	$scope.delete=function deleteEstudiantes(id){
		console.log("imprime:"+id);
		OperationsStudents.deleteStudents(id,function(response){
				if(response.success){
				    $location.path('estudiantes');
				    $route.reload();
				}
		});

	};
	$scope.postEstudiante = function postEstudiante(estudiante) {
		console.log(estudiante);
		OperationsStudents.updateStudents($scope.estudiante, function(response) {

			if (response.success) {
				console.log("exito");
				//$scope.listaStudents.push(estudiante);
			    $location.path('estudiantes');
			    $route.reload();
			}

		});
	};

});
