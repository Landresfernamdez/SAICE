'use strict'
angular.module('userModule')
.controller('estadisticasController',function($scope,OperationsStadistics,$location,$route){
    $scope.listaPpolizas=[];
    $scope.listatemp=[];
                var temp={
                        text: "",
                        values: [],
                        backgroundColor: ""
                }
                function getRandomColor() {
                    var letters = '0123456789ABCDEF';
                    var color = '#';
                    for (var i = 0; i < 6; i++ ) {
                        color += letters[Math.floor(Math.random() * 16)];
                    }
                    return color;
                }
                $scope.getSPpolizas = function getSPpolizas(){
                    OperationsStadistics.getStadisticsPpolizas( function(res){
                        $scope.listaPpolizas = res;
                        console.log("respuesta");
                        console.log($scope.listaPpolizas);
                        console.log($scope.listaPpolizas.length);
                        for (var i = 0; i < $scope.listaPpolizas.length; i++) {
                            temp.text="id:"+$scope.listaPpolizas[i].id_poliza+", "+"monto:"+$scope.listaPpolizas[i].monto;
                            temp.values=[parseInt($scope.listaPpolizas[i].total)];
                            temp.backgroundColor=getRandomColor();
                            $scope.listatemp[i]=temp;
                            temp={};
                        };
                        console.log($scope.listatemp);
                        $scope.myJson.series=$scope.listatemp
                            console.log($scope.myJson);
                                });
                };
                $scope.getSPpolizas();
                $scope.myJson={
                                globals: {
                                    shadow: false,
                                    fontFamily: "Verdana",
                                    fontWeight: "100"
                                },
                                type: "pie",
                                backgroundColor: "#fff",

                                legend: {
                                    layout: "x5",
                                    position: "50%",
                                    borderColor: "transparent",
                                    marker: {
                                        borderRadius: 10,
                                        borderColor: "transparent"
                                    }
                                },
                                tooltip: {
                                    text: "%v requests"
                                },
                                plot: {
                                    refAngle: "-90",
                                    borderWidth: "0px",
                                    valueBox: {
                                        placement: "in",
                                        text: "%npv %",
                                        fontSize: "15px",
                                        textAlpha: 1,
                                    }},
                                    series:$scope.listatemp
                            } ;
    
});
