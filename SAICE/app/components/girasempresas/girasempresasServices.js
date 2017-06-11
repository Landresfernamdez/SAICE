/**
 * Created by Andres on 6/10/2017.
 */
'use strict'
angular.module('userModule')
    .factory('OperationsToursCoorporations',function($http,$location){
        var urlp="http://localhost:8080/SAICE/server/giras/CRUDgiras.php?Funcion=";
        var respuesta={
            getToursCoorporations: function(callback){
                $http.get(
                    urlp+"ObtenertodosToursempresas"
                ).success(function successCallback(response){
                    callback(response);
                }).error(function errorCallback(response) {
                    //En caso de fallo en la peticion entra en esta funcion
                    callback(response);
                });
            },
            putToursCoorporations:function(gira,callback){
                $http({
                    method  :'POST',
                    url     : urlp+"putGirasempresas",
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
