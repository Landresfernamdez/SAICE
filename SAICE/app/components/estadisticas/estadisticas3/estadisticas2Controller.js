'use strict'
angular.module('userModule')
    .controller('estadisticas2Controller',function($scope,OperationsStadistics2,$location,$route){
        $scope.listaEnotas=[];
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
        $scope.getSEnotas = function getSEnotas(){
            OperationsStadistics2.getStadisticsEnotas(function(res){
                $scope.listaEnotas = res;
                console.log("respuesta");
                console.log($scope.listaEnotas);
                console.log($scope.listaEnotas.length);
                for (var i = 0; i <4; i++) {
                    if(i==0){
                        temp.text="promedio <=70: "+$scope.listaEnotas[i].cantidad_menor_70+" total:"+$scope.listaEnotas[i].total_practicas;
                        temp.values=[parseInt($scope.listaEnotas[i].cantidad_menor_70)];
                        temp.backgroundColor=getRandomColor();
                        $scope.listatemp[i]=temp;
                        temp={};
                    }else if(i==1){
                        temp.text="promedio >=80: "+$scope.listaEnotas[i].cantidad_70_80+" total:"+$scope.listaEnotas[i].total_practicas;
                        temp.values=[parseInt($scope.listaEnotas[i].cantidad_70_80)];
                        temp.backgroundColor=getRandomColor();
                        $scope.listatemp[i]=temp;
                        temp={};

                    }else if(i==2){
                        temp.text="promedio 80>=90: "+$scope.listaEnotas[i].cantidad_80_90+" total:"+$scope.listaEnotas[i].total_practicas;
                        temp.values=[parseInt($scope.listaEnotas[i].cantidad_80_90)];
                        temp.backgroundColor=getRandomColor();
                        $scope.listatemp[i]=temp;
                        temp={};
                    }
                    else if(i==3){
                        temp.text="promedio 90>=100: "+$scope.listaEnotas[i].cantidad_90_100+" total:"+$scope.listaEnotas[i].total_practicas;
                        temp.values=[parseInt($scope.listaEnotas[i].cantidad_90_100)];
                        temp.backgroundColor=getRandomColor();
                        $scope.listatemp[i]=temp;
                        temp={};
                    }
                };
                console.log($scope.listatemp);
                //$scope.myJson1.series=$scope.listatemp
                //console.log($scope.myJson);
            });
        };
        $scope.getSEnotas();
        $scope.myJson2={
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
/*[{
 text: "10.0.0.80",
 values: [4660],
 backgroundColor: "#FA6E6E #FA9494",
 }, {
 text: "167.114.156.198",
 values: [1807],
 backgroundColor: "#F1C795 #feebd2"
 }, {
 text: "103.24.77.25",
 values: [1611],
 backgroundColor: "#FDAA97 #FC9B87"
 }, {
 text: "46.4.68.142",
 values: [1341],
 backgroundColor: "#D1084F"
 }, {
 text: "10.0.0.117",
 values: [1269],
 backgroundColor: "#D2D6DE",
 }]      */