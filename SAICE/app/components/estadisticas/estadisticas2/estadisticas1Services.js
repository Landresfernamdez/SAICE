'use strict'
angular.module('userModule')
    .factory('OperationsStadistics1',function($http,$location){
        var urlp="http://localhost:8080/SAICE/server/estadisticas/CRUDestadisticas.php?Funcion=";
        var respuesta={
            getStadisticsEprovincias: function(callback){
                $http.get(
                    urlp+"ObtenerSPromedioEXprovincia"
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
