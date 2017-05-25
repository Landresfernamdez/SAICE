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
	$scope.refresh=function refresh(){

				
			    $scope.estudiante.carnet="";
				$scope.estudiante.cedula="";
				$scope.estudiante.telefono="";
				$scope.estudiante.correo="";
				$scope.estudiante.nombre="";
				$scope.estudiante.apellido1="";
				$scope.estudiante.apellido2="";
				$scope.estudiante.provincia="";
				$scope.estudiante.canton="";
				$scope.estudiante.distrito="";
				$scope.estudiante.detalle="";
				$scope.estudiante.id_poliza="";

				$scope.getEstudiantes();
				console.log($scope.listaStudents);
				console.log($scope.estudiante);
			    $location.path('estudiantes');
			    $route.reload();

			    console.log("refresco");
	}
	$scope.actualizarPersona=function actualizarPersona(estudiante){
		$scope.estudiante=estudiante;
		console.log("actualiza:");
		console.log($scope.estudiante);

	}
	$scope.buscarEstudiante=function buscarEstudiante(id){
		OperationsStudents.searchStudent(id,function(response) {
				console.log("exito en la busqueda");
				$scope.listaStudents=[];
				$scope.listaStudents=response;
				console.log(response);
			    //$location.path('estudiantes');
			    //$route.reload();
		});

	}

});
