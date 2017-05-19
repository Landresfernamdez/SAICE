'use strict'
angular.module('userModule')
    .factory('OperationsStudents',function($http,$location){
        var urlp="http://localhost:8080/SAICE/server/estudiantes/CRUDestudiantes.php?Funcion=";
        var respuesta={
            getStudents: function(callback){
                $http.get(
                    urlp+"ObtenertodosStudents"
                ).success(function successCallback(response){
                    callback(response);
                }).error(function errorCallback(response) {
                    //En caso de fallo en la peticion entra en esta funcion
                    callback(response);
                });
            },
            //Esta funcion se encarga de insertar un estudiante mediante la conexion con el servidor
            putStudents:function(estudiante,callback){
                 $http({
                    method  :'POST',
                    url     : urlp+"putEstudiantes",
                    data    : estudiante

                })// si la insercion fue exitosa entra al succes de lo contrario retorna un error departe del servidor
                    .success(function(data){
                        if (data) {
                            // Showing errors.

                            alert("Se ha producido un error en la insercion"+data);
                            callback({success: false});
                        } else {
                            callback({success: true});
                            alert("insercion exitosa");
                        }
                    });
            },
            deleteStudents:function(id,callback){
                $http({
                    method  : 'POST',
                    url     : urlp+"deleteEstudiantes",
                    data    : {ida:id}

                })// si la insercion fue exitosa entra al succes de lo contrario retorna un error departe del servidor
                    .success(function(data){
                        if (data) {
                            // Showing errors.
                            console.log(data);
                            console.log(id);
                            alert("Se ha producido un error a la hora de eliminar el dato");
                            callback({success: false});
                        } else {
                            callback({success: true});
                            alert("se elimino exitosamente ");
                        }
                    });
            },
            updateStudents:function(estudiante,callback){
                $http({
                    method  : 'POST',
                    url     : urlp+"updateEstudiantes",
                    data    : estudiante

                })// si la insercion fue exitosa entra al succes de lo contrario retorna un error departe del servidor
                    .success(function(data){
                        if (data) {
                            // Showing errors.
                            console.log(data);
                            alert("Se ha producido un error a la hora de actualizar el estudiante");
                            callback({success: false});
                        } else {
                            callback({success: true});
                            alert("se actualizo exitosamente ");
                        }
                    });
            }
        }
        return respuesta;
    });
