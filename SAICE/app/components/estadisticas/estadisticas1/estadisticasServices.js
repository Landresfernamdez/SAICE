'use strict'
angular.module('userModule')
    .factory('OperationsStadistics',function($http,$location){
        var urlp="http://localhost:8080/SAICE/server/estadisticas/CRUDestadisticas.php?Funcion=";
        var respuesta={
        	getStadisticsPpolizas: function(callback){
                $http.get(
                    urlp+"ObtenerSPorcentageEPoliza"
                ).success(function successCallback(response){
                    callback(response);
                    console.log("entro service");
                }).error(function errorCallback(response) {
                    //En caso de fallo en la peticion entra en esta funcion
                    callback(response);
                });
            }
        }
        return respuesta;
    });
