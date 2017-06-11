'use strict'
angular.module('userModule')
    .factory('OperationsSections',function($http,$location){
        var urlp="http://localhost:8080/SAICE/server/secciones/CRUDsecciones.php?Funcion=";
        var respuesta={
            getSections: function(callback){
                $http.get(
                    urlp+"ObtenertodosSections"
                ).success(function successCallback(response){
                    callback(response);
                }).error(function errorCallback(response) {
                    //En caso de fallo en la peticion entra en esta funcion
                    callback(response);
                });
            },
            //Esta funcion se encarga de insertar un estudiante mediante la conexion con el servidor
            putSections:function(seccion,callback){
                 $http({
                    method  :'POST',
                    url     : urlp+"putSecciones",
                    data    : seccion

                })// si la insercion fue exitosa entra al succes de lo contrario retorna un error departe del servidor
                    .success(function(data){
                            alert("insercion exitosa");
                            console.log("service:");
                            console.log(seccion);
                            callback({success: true});
                    }).error(function(data) {
                    //En caso de fallo en la peticion entra en esta funcion
                            alert("Se ha producido un error en la insercion"+data);
                            callback({success: false});
                });
            },
            deleteSections:function(id,callback){
                $http({
                    method  : 'POST',
                    url     : urlp+"deleteSecciones",
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
            }
        }
        return respuesta;
    });
