'use strict'
angular.module('userModule')
    .factory('OperationsFuncionarios',function($http,$location){
        var urlp="http://localhost:8080/SAICE/server/funcionarios/CRUDfuncionarios.php?Funcion=";
        var respuesta={
            getofficials: function(callback){
                $http.get(
                    urlp+"ObtenertodosFuncionarios"
                ).success(function successCallback(response){
                    callback(response);
                }).error(function errorCallback(response) {
                    //En caso de fallo en la peticion entra en esta funcion
                    callback(response);
                });
            },
            //Esta funcion se encarga de insertar un estudiante mediante la conexion con el servidor
            putofficials:function(funcionario,callback){
                 $http({
                    method  :'POST',
                    url     : urlp+"putFuncionarios",
                    data    : funcionario

                })// si la insercion fue exitosa entra al succes de lo contrario retorna un error departe del servidor
                    .success(function(data){
                            alert("insercion exitosa");
                            console.log("service:");
                            console.log(funcionario);
                            callback({success: true});
                    }).error(function(data) {
                    //En caso de fallo en la peticion entra en esta funcion
                            alert("Se ha producido un error en la insercion"+data);
                            callback({success: false});
                });
            },
            deleteofficials:function(id,callback){
                $http({
                    method  : 'POST',
                    url     : urlp+"deleteFuncionarios",
                    data    : {ida:id}

                })// si la insercion fue exitosa entra al succes de lo contrario retorna un error departe del servidor
                    .success(function(data){
                            // Showing errors.
                            callback({success: true});
                            alert("se elimino exitosamente ");
                            console.log(data);
                            console.log(id);
                        
                    }).error(function(data) {
                    //En caso de fallo en la peticion entra en esta funcion
                            alert("Se ha producido un error en la eliminacion"+data);
                            callback({success: false});
                });
            },
            updateofficials:function(funcionario,callback){
                $http({
                    method  : 'POST',
                    url     : urlp+"updateFuncionarios",
                    data    : funcionario

                })// si la insercion fue exitosa entra al succes de lo contrario retorna un error departe del servidor
                    .success(function(data){
                            console.log("service:");
                            console.log(funcionario);
                            alert("se actualizo exitosamente "+data);
                            callback({success: true});
                    }).error(function(data) {
                    //En caso de fallo en la peticion entra en esta funcion
                            alert("Se ha producido un error en la eliminacion"+data);
                            callback({success: false});
                });
            }
        }
        return respuesta;
    });
