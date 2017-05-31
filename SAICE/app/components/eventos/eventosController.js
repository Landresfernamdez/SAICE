'use strict'
angular.module('userModule')
.controller('eventosController',function($scope,OperationsEvents,$location,$route){
	$scope.Id_evento="";
	$scope.listaEvents = [];
	$scope.evento = {
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
	$scope.getEventos = function getEventos() {

		OperationsEvents.getEvents( function(res) {
			$scope.listaEvents = res;
		});

	};
	
	$scope.getEventos();
	$scope.putEvento = function putEvento(evento) {

		OperationsEvents.putEvents(evento, function(response) {

			if (response.success) {
				console.log("exito");
			    $location.path('eventos');
			    $route.reload();
			}

		});
	};
	$scope.delete=function deleteEventos(id){
		console.log("imprime:"+$scope.evento.Id_evento);
		OperationsEvents.deleteEvents($scope.evento.Id_evento,function(response){
				if(response.success){
				    $location.path('eventos');
				    $route.reload();
				}
		});

	};
	$scope.postEvento = function postEvento(evento) {
		OperationsEvents.updateEvents($scope.evento, function(response) {

			if (response.success) {
				console.log("exito");
			    $location.path('eventos');
			    $route.reload();
			}
		});
	};
	$scope.actualizarEvento=function actualizarEvento(evento){
		$scope.evento=evento;
		console.log("actualiza:");
		console.log($scope.evento);

	}

});
