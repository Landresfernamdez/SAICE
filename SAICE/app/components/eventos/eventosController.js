'use strict'
angular.module('userModule')
.controller('eventosController',function($scope,OperationsEvents,$location,$route){
	$scope.id_evento="";
	$scope.listaEvents = [];
	$scope.evento = {
		id_evento:"",
		nombre:"",
		descripcion:"",
		fechainicio:"",
		fechafinal:"",
		nombre_completo:"",
		rol:"",
		cedula:""
	};
	$scope.getEventos = function getEventos() {
		console.log("entro");
		OperationsEvents.getEvents( function(res) {
			$scope.listaEvents = res;
			console.log($scope.listaEvents);
		});

	};
	
	$scope.getEventos();
	$scope.putEvento = function putEvento(evento) {

		OperationsEvents.putEvents(evento, function(response) {

			if (response.success){
				console.log(response);
			    $location.path('eventos');
			    $route.reload();
			}

		});
	};
	$scope.delete=function deleteEventos(id){
		console.log("imprime:"+$scope.evento.id_evento);
		OperationsEvents.deleteEvents($scope.evento.id_evento,function(response){
				if(response.success){
				    $location.path('eventos');
				    $route.reload();
				}
		});

	};
	$scope.postEvento = function postEvento(evento) {
		OperationsEvents.updateEvents($scope.evento, function(response) {

			if (response.success) {
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
