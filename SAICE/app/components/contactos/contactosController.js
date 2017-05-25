'use strict'
angular.module('userModule')
.controller('contactosController',function($scope,OperationsContacts,$location,$route){

	$scope.listaContacts = [];
	$scope.contacto = {
		puesto:"",
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
		id_empresa:""
	};
	console.log("entro a comprobacion");
	$scope.getContactos = function getContactos() {

		OperationsContacts.getContacts( function(res) {
			$scope.listaContacts = res;
		});

	};
	
	$scope.getContactos();
	$scope.putContacto = function putContacto(contacto) {

		OperationsContacts.putContacts(contacto, function(response) {

			if (response.success) {
				console.log("exito");
			    $location.path('contactos');
			    $route.reload();
			}

		});
	};
	$scope.delete=function deleteContactos(id){
		console.log("imprime:"+$scope.contacto.cedula);
		OperationsContacts.deleteContacts($scope.contacto.cedula,function(response){
				if(response.success){
				    $location.path('contactos');
				    $route.reload();
				}
		});

	};
	$scope.postContacto = function postContacto(contacto) {
		OperationsContacts.updateContacts($scope.contacto, function(response) {

			if (response.success) {
				console.log("exito");
			    $location.path('contactos');
			    $route.reload();
			}
		});
	};
	$scope.actualizarContacto=function actualizarContacto(contacto){
		$scope.contacto=contacto;
		console.log("actualiza:");
		console.log($scope.contacto);

	}

});
