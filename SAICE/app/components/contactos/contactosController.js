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

		OperationsContacts.putContacts($scope.contacto, function(response) {

			if (response.success) {
				console.log("exito");
			    $location.path('contactos');
			    $route.reload();
			}

		});
	};
	$scope.delete=function deleteContactos(id){
		console.log("imprime:"+id);
		OperationsContacts.deleteContacts(id,function(response){
				if(response.success){
				    $location.path('contactos');
				    $route.reload();
				}
		});

	};
	$scope.postContacto = function postContacto(contacto) {
		OperationsContacts.updateContacts(contacto, function(response) {

			if (response.success) {
				console.log("exito");
			    $location.path('contactos');
			    $route.reload();
			}
		});
	};
	$scope.refresh=function refresh(){

				
			    $scope.contacto.puesto="";
				$scope.contacto.cedula="";
				$scope.contacto.telefono="";
				$scope.contacto.correo="";
				$scope.contacto.nombre="";
				$scope.contacto.apellido1="";
				$scope.contacto.apellido2="";
				$scope.contacto.provincia="";
				$scope.contacto.canton="";
				$scope.contacto.distrito="";
				$scope.contacto.detalle="";
				$scope.contacto.ID_empresa="";

				$scope.getContactos();
				console.log($scope.listaContacts);
				console.log($scope.contacto);
			    $location.path('contactos');
			    $route.reload();

			    console.log("refresco");
	}
	$scope.actualizarContacto=function actualizarContacto(contacto){
		$scope.contacto=contacto;
		console.log("actualiza:");
		console.log($scope.contacto);

	}

});
