'use strict'
angular.module('userModule')
    .factory('OperationsTourssections',function($http,$location){
        var urlp="http://localhost:8080/SAICE/server/giras/CRUDgiras.php?Funcion=";
        var respuesta={
            getToursSecciones: function(callback){
                $http.get(
                    urlp+"ObtenertodosTourssecciones"
                ).success(function successCallback(response){
                    callback(response);
                }).error(function errorCallback(response) {
                    //En caso de fallo en la peticion entra en esta funcion
                    callback(response);
                });
            },
            putToursSections:function(gira,callback){
                $http({
                    method  :'POST',
                    url     : urlp+"putGirassecciones",
                    data    : gira

                })// si la insercion fue exitosa entra al succes de lo contrario retorna un error departe del servidor
                    .success(function(data){
                        alert("insercion exitosa");
                        console.log("service:");
                        console.log(gira);
                        callback({success: true});
                    }).error(function(data) {
                    //En caso de fallo en la peticion entra en esta funcion
                    alert("Se ha producido un error en la insercion"+data);
                    callback({success: false});
                });
            }
        }
        return respuesta;
    });
/**
 * Created by Andres on 6/10/2017.
 */
