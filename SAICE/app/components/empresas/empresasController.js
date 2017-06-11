'use strict'
angular.module('userModule')
.controller('empresasController',function($scope,OperationsCoorporations,$location,$route){
	$scope.id_empresa="";
	$scope.listaCoorporations = [];
	$scope.empresa = {
		id_empresa:"",
		nombre:"",
		telefono:"",
		correo:"",
		provincia:"",
		canton:"",
		distrito:"",
		detalle:""
	};
	$scope.getEmpresas = function getEmpresas() {

		OperationsCoorporations.getCoorporations( function(res) {
			$scope.listaCoorporations = res;
		});

	};
	
	$scope.getEmpresas();
	$scope.putEmpresa = function putEmpresa(empresa) {

		OperationsCoorporations.putCoorporations(empresa, function(response) {

			if (response.success) {
			    $location.path('empresas');
			    $route.reload();
			}

		});
	};
	$scope.delete=function deleteEmpresas(id){
		console.log("imprime:"+$scope.empresa.id_empresa);
		OperationsCoorporations.deleteCoorporations($scope.empresa.id_empresa,function(response){
				if(response.success){
				    $location.path('empresas');
				    $route.reload();
				}
		});

	};
	$scope.postEmpresa = function postEmpresa(empresa) {
		OperationsCoorporations.updateCoorporations($scope.empresa, function(response) {
			if (response.success) {
				console.log($scope.empresa);
			    $location.path('empresas');

			    $route.reload();
			}
		});
	};
	$scope.actualizarEmpresa=function actualizarEmpresa(empresa){
		$scope.empresa=empresa;
		console.log("actualiza:");
		console.log($scope.empresa);
	}

});
