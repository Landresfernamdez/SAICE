'use strict'
angular.module('userModule')
    .controller('girasempresasController',function($scope,OperationsToursCoorporations,$location,$route){
        $scope.listaCoorporations=[];
        $scope.giraempresas = {
            id_gira:"",
            id_empresa:""
        };
        $scope.getGirasEmpresas = function getGirasEmpresas() {
            OperationsToursCoorporations.getToursCoorporations(function(res) {
                $scope.listaCoorporations = res;
            });
        };
        $scope.getGirasEmpresas();
        $scope.putGiraEmpresas = function putGiraEmpresas(gira) {

            OperationsToursCoorporations.putToursCoorporations(gira, function(response) {
                if (response.success) {
                    $location.path('girase');
                    $route.reload();
                }

            });
        };
    });
/**
 * Created by Andres on 6/10/2017.
 */
