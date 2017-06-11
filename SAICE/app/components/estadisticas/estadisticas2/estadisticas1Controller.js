'use strict'
angular.module('userModule')
    .controller('estadisticas1Controller',function($scope,OperationsStadistics1,$location,$route){
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
        $scope.getSEprovincias = function getSEprovincias(){
            OperationsStadistics1.getStadisticsEprovincias( function(res){
                $scope.listaEnotas = res;
                console.log("respuesta");
                console.log($scope.listaEnotas);
                console.log($scope.listaEnotas.length);
                for (var i = 0; i < $scope.listaEnotas.length; i++) {
                    temp.text="provincia:"+$scope.listaEnotas[i].provincia+"total:"+$scope.listaEnotas[i].total;
                    temp.values=[parseInt($scope.listaEnotas[i].total_en_provincia)];
                    temp.backgroundColor=getRandomColor();
                    $scope.listatemp[i]=temp;
                    temp={};
                };
                console.log($scope.listatemp);
                //$scope.myJson1.series=$scope.listatemp
                //console.log($scope.myJson);
            });
        };
        $scope.getSEprovincias();
        $scope.myJson1={
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