angular.module('userModule')
<<<<<<< HEAD:SAICE/app/components/estudiantes/estudiantesController.js
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
=======
.controller('GirasController',function($scope,OperationsTours,$location){
    $scope.listaTours=[];
	$scope.Tours={
		id_gira:"",
		fecha_inicio:"",
		fecha_final:"",
		costo:"",
		duracion:"",
>>>>>>> ramasergio:SAICE/app/components/Giras/GirasController.js
		provincia:"",
		canton:"",
		distrito:"",
		detalle:""
	};
<<<<<<< HEAD:SAICE/app/components/estudiantes/estudiantesController.js
	console.log("entro a comprobacion");
	$scope.getEstudiantes = function getEstudiantes() {

		OperationsStudents.getStudents( function(res) {
			$scope.listaStudents = res;
			console.log($scope.listaStudents)
		});
=======
	console.log("entro");
    $scope.getTours=function getTours(){
        OperationsTours.getTours(function(res){
		  $scope.listaTours=res;
	});
	}

	$scope.getTours();
});


/*'use strict'
>>>>>>> ramasergio:SAICE/app/components/Giras/GirasController.js

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

});*/