'use strict'
angular.module('userModule')
    .factory('OperationsTours',function($http,$location){
        var urlp="http://localhost:8080/SAICE/SAICE/server/Giras/CRUDgiras.php?Funcion="
        var respuesta={
            getTours: function(callback){
                $http.get(
                    urlp+"getTours"
                ).success(function successCallback(response){
                    // Esta funcion es la que se ejecuta
                    // cuando la peticion es exitosa
                    //response es la variable en la que se devuelven los datos
                    //En este caso particular nuestro response esta estructurado de manera que
                    //los datos que interesan estan en el atributo content
                    //Se devuelve un callback el cual se ejecuta en el controller
                    console.log("Aqui estoy rasta")
                    console.log(response);
                    callback(response);
                }).error(function errorCallback(response) {
                    //En caso de fallo en la peticion entra en esta funcion
                    console.log("fallo", response);
                    callback(response);
                });
            }
            putTours:function(Tours,callback){
                $http({
                    method:'POST',
                    url:urlp+"putTours",
                    data:Tours
                }).success(function(data)){
                    alert("Se inserto una gira");
                    callback({success:true});
                }).error(function(data){
                    alert("Ocurrio un error al insertar"+data);
                    callback({success:false});
                });
            },

        }
        return respuesta;
    });


/*
*/