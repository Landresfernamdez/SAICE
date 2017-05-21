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
                            alert("insercion exitosa");
                            console.log("service:");
                            console.log(estudiante);
                            callback({success: true});
                    }).error(function(data) {
                    //En caso de fallo en la peticion entra en esta funcion
                            alert("Se ha producido un error en la insercion"+data);
                            callback({success: false});
                });
            },
            deleteStudents:function(id,callback){
                $http({
                    method  : 'POST',
                    url     : urlp+"deleteEstudiantes",
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
            updateStudents:function(estudiante,callback){
                $http({
                    method  : 'POST',
                    url     : urlp+"updateEstudiantes",
                    data    : estudiante

                })// si la insercion fue exitosa entra al succes de lo contrario retorna un error departe del servidor
                    .success(function(data){
                            console.log("service:");
                            console.log(estudiante);
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
