'use strict'
angular.module('userModule')
.controller('girasController',function($scope,OperationsTours,$location,$route){
	$scope.listaTours = [];
	$scope.gira = {
		id_gira:"",
		fecha_inicio:"",
		fecha_final:"",
		costo:"",
		duracion:"",
		provincia:"",
		canton:"",
		distrito:"",
		detalle:""
	};
	$scope.getGiras = function getGiras() {
		OperationsTours.getTours( function(res) {
			$scope.listaTours = res;
		});

	};
	$scope.getGiras();
	$scope.putGira = function putGira(gira) {

		OperationsTours.putTours(gira, function(response) {

			if (response.success) {
			    $location.path('giras');
			    $route.reload();
			}

		});
	};
	$scope.delete=function deleteGiras(id){
		console.log("imprime:"+$scope.gira.id_gira);
		OperationsTours.deleteTours($scope.gira.id_gira,function(response){
				if(response.success){
				    $location.path('giras');
				    $route.reload();
				}
		});

	};
	$scope.postGira = function postGira(gira) {
		OperationsTours.updateTours($scope.gira, function(response) {
			if (response.success) {
				console.log("exito");
			    $location.path('giras');
			    $route.reload();
			}
		});
	};
	$scope.actualizarGira=function actualizarGira(gira){
		$scope.gira=gira;
		console.log("actualiza:");
		console.log($scope.gira);

	}
});
