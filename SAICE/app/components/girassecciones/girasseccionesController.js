'use strict'
angular.module('userModule')
    .controller('girasseccionesController',function($scope,OperationsTourssections,$location,$route){
        $scope.listaSections=[];
        $scope.giraSections = {
            id_gira:"",
            id_secciones:""
        };
        $scope.getGirasSecciones = function getGirasSecciones(){
            OperationsTourssections.getToursSecciones(function(res) {
                $scope.listaSections = res;
            });

        };
        $scope.getGirasSecciones();
        $scope.putGiraSecciones = function putGiraSecciones(gira){
            OperationsTourssections.putToursSections(gira, function(response) {

                if (response.success) {
                    $location.path('girass');
                    $route.reload();
                }

            });
        };
    });
/**
 * Created by Andres on 6/10/2017.
 */
