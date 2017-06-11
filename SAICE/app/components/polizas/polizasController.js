'use strict'
angular.module('userModule')
.controller('polizasController',function($scope,OperationsPolices,$location,$route){
	$scope.id_poliza="";
	$scope.listaPolices = [];
	$scope.poliza = {
		id_poliza:"",
		descripcion:"",
		monto:"",
		fecha_vencimiento:"",
		aseguradora:""
	};
	$scope.getPolizas = function getPolizas() {

		OperationsPolices.getPolices( function(res) {
			$scope.listaPolices = res;
		});

	};
	
	$scope.getPolizas();
	$scope.putPoliza = function putPoliza(poliza) {
		var polizatemp={
		descripcion:"",
		monto:"",
		fecha_vencimiento:"",
		aseguradora:""
	                  };
	    polizatemp.descripcion=poliza.descripcion;
	    polizatemp.monto=poliza.monto;
	    polizatemp.fecha_vencimiento=poliza.fecha_vencimiento;
	    polizatemp.aseguradora=poliza.aseguradora;
	    
		OperationsPolices.putPolices(polizatemp, function(response) {
			if (response.success) {
			    $location.path('polizas');
			    $route.reload();
			}

		});
	};
	$scope.delete=function deletePolizas(id){
		console.log("imprime:"+$scope.poliza.id_poliza);
		OperationsPolices.deletePolices($scope.poliza.id_poliza,function(response){
				if(response.success){
				    $location.path('polizas');
				    $route.reload();
				}
		});

	};
	$scope.postPoliza = function postPoliza(poliza) {
		OperationsPolices.updatePolices($scope.poliza, function(response) {

			if (response.success) {
			    $location.path('polizas');
			    $route.reload();
			}
		});
	};
	$scope.actualizarPoliza=function actualizarPoliza(poliza){
		$scope.poliza=poliza;
		console.log("actualiza:");
		console.log($scope.poliza);

	}

});
