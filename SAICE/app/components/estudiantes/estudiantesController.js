'use strict'
angular.module('userModule')
.controller('estudiantesController',function($scope,OperationsStudents,$location,$route){
	$scope.cedula="";
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
			console.log($scope.listaStudents)
		});

	};
	
	$scope.getEstudiantes();
	$scope.putEstudiante = function putEstudiante(estudiante) {

		OperationsStudents.putStudents(estudiante, function(response) {

			if (response.success) {
				console.log("exito");
			    $location.path('estudiantes');
			    $route.reload();
			}

		});
	};
	$scope.delete=function deleteEstudiantes(id){
		console.log("imprime:"+$scope.estudiante.cedula);
		OperationsStudents.deleteStudents($scope.estudiante.cedula,function(response){
				if(response.success){
				    $location.path('estudiantes');
				    $route.reload();
				}
		});

	};
	$scope.postEstudiante = function postEstudiante(estudiante) {
		OperationsStudents.updateStudents($scope.estudiante, function(response) {

			if (response.success) {
				console.log("exito");
			    $location.path('estudiantes');
			    $route.reload();
			}
		});
	};
	$scope.actualizarPersona=function actualizarPersona(estudiante){
		$scope.estudiante=estudiante;
		console.log("actualiza:");
		console.log($scope.estudiante);

	}

});
