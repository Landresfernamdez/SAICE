'use strict'
angular.module('userModule')
.controller('seccionesController',function($scope,OperationsSections,$location,$route){
	$scope.id_secciones="";
	$scope.listaSections = [];
	$scope.estudiante = {
		id_secciones:""
	};
	$scope.getSecciones = function getSecciones() {

		OperationsSections.getSections( function(res) {
			$scope.listaSections = res;
		});

	};
	
	$scope.getSecciones();
	$scope.putSeccion = function putSeccion(seccion) {

		OperationsSections.putSections(seccion, function(response) {

			if (response.success) {
			    $location.path('secciones');
			    $route.reload();
			}

		});
	};
	$scope.delete=function deleteSecciones(id){
		console.log("imprime:"+$scope.seccion.id_secciones);
		OperationsSections.deleteSections($scope.seccion.id_secciones,function(response){
				if(response.success){
				    $location.path('secciones');
				    $route.reload();
				}
		});

	};
	$scope.actualizarSeccion=function actualizarSeccion(seccion){
		$scope.seccion=seccion;
		console.log("actualiza:");
		console.log($scope.seccion);

	}

});
