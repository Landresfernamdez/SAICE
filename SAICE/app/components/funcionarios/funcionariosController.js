'use strict'
angular.module('userModule')
.controller('funcionariosController',function($scope,OperationsFuncionarios,$location,$route){

	$scope.listaFuncionarios = [];
	$scope.funcionario = {
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
		detalle:""
	};
	console.log("entro a comprobacion");
	$scope.getFuncionarios = function getFuncionarios() {

		OperationsFuncionarios.getofficials( function(res) {
			$scope.listaFuncionarios = res;
		});

	};
	
	$scope.getFuncionarios();
	$scope.putFuncionarios = function putFuncionarios(funcionario) {

		OperationsFuncionarios.putofficials(funcionario, function(response) {

			if (response.success) {
				console.log("exito");
			    $location.path('funcionarios');
			    $route.reload();
			}

		});
	};
	$scope.delete=function deleteFuncionarios(id){
		console.log("imprime:"+$scope.funcionario.cedula);
		OperationsFuncionarios.deleteofficials($scope.funcionario.cedula,function(response){
				if(response.success){
				    $location.path('funcionarios');
				    $route.reload();
				}
		});

	};
	$scope.postFuncionarios = function postFuncionarios(funcionario) {
		OperationsFuncionarios.updateofficials($scope.funcionario, function(response) {

			if (response.success) {
				console.log("exito");
			    $location.path('funcionarios');
			    $route.reload();
			}
		});
	};
	$scope.refresh=function refresh(){

				
			    $scope.funcionario.carnet="";
				$scope.funcionario.cedula="";
				$scope.funcionario.telefono="";
				$scope.funcionario.correo="";
				$scope.funcionario.nombre="";
				$scope.funcionario.apellido1="";
				$scope.funcionario.apellido2="";
				$scope.funcionario.provincia="";
				$scope.funcionario.canton="";
				$scope.funcionario.distrito="";
				$scope.funcionario.detalle="";

				$scope.getFuncionarios();
				console.log($scope.listaFuncionarios);
				console.log($scope.funcionario);
			    $location.path('funcionarios');
			    $route.reload();

			    console.log("refresco");
	}
	$scope.actualizarFuncionario=function actualizarFuncionario(funcionario){
		$scope.funcionario=funcionario;
		console.log("actualiza:");
		console.log($scope.funcionario);

	}

});
