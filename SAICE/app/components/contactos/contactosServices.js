'use strict'
angular.module('userModule')
    .factory('OperationsContacts',function($http,$location){
        var urlp="http://localhost:8080/SAICE/server/contactos/CRUDcontactos.php?Funcion=";
        var respuesta={
            getContacts: function(callback){
                $http.get(
                    urlp+"ObtenertodosContactos"
                ).success(function successCallback(response){
                    callback(response);
                }).error(function errorCallback(response) {
                    //En caso de fallo en la peticion entra en esta funcion
                    callback(response);
                });
            },
            //Esta funcion se encarga de insertar un estudiante mediante la conexion con el servidor
            putContacts:function(contacto,callback){
                 $http({
                    method  :'POST',
                    url     : urlp+"putContactos",
                    data    : contacto

                })// si la insercion fue exitosa entra al succes de lo contrario retorna un error departe del servidor
                    .success(function(data){
                            alert("insercion exitosa");
                            console.log("service:");
                            console.log(contacto);
                            callback({success: true});
                    }).error(function(data) {
                    //En caso de fallo en la peticion entra en esta funcion
                            alert("Se ha producido un error en la insercion"+data);
                            callback({success: false});
                });
            },
            deleteContacts:function(id,callback){
                $http({
                    method  : 'POST',
                    url     : urlp+"deleteContactos",
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
            updateContacts:function(contacto,callback){
                $http({
                    method  : 'POST',
                    url     : urlp+"updateContactos",
                    data    : contacto

                })// si la insercion fue exitosa entra al succes de lo contrario retorna un error departe del servidor
                    .success(function(data){
                            console.log("service:");
                            console.log(contacto);
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
