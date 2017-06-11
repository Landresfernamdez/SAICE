'use strict'
angular.module('userModule')
.controller('practicasController',function($scope,OperationsPractices,$location,$route){
	$scope.id_practicas="";
	$scope.listaPractices = [];
	$scope.practica = {
		id_practicas:"",
		fecha_inicio:"",
		fecha_final:"",
		nota:"",
		cedula:"",
		nombre:"",
		estado:"",
		id_empresa:""
	};
	$scope.getPracticas = function getPracticas() {
		OperationsPractices.getPractices( function(res) {
			$scope.listaPractices = res;
			console.log($scope.listaPractices);
		});

	};
	
	$scope.getPracticas();
	$scope.putPractica = function putPractica(practica) {

		OperationsPractices.putPractices(practica, function(response) {

			if (response.success) {
			    $location.path('practicas');
			    $route.reload();
			}

		});
	};
	$scope.delete=function deletePracticas(id){
		console.log("imprime:"+$scope.practica.id_practicas);
		OperationsPractices.deletePractices($scope.practica.id_practicas,function(response){
				if(response.success){
				    $location.path('practicas');
				    $route.reload();
				}
		});

	};
	$scope.postPractica = function postPractica(practica) {
		OperationsPractices.updatePractices($scope.practica, function(response) {

			if (response.success) {
			    $location.path('practicas');
			    $route.reload();
			}
		});
	};
	$scope.actualizarPractica=function actualizarPractica(practica){
		$scope.practica=practica;
		console.log("actualiza:");
		console.log($scope.practica);

	}

});
