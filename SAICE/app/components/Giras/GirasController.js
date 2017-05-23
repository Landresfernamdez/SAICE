angular.module('userModule')
.controller('GirasController',function($scope,OperationsTours,$location){
    $scope.listaTours=[];
	$scope.Tours={
		id_gira:"",
		fecha_inicio:"",
		fecha_final:"",
		costo:"",
		duracion:"",
		provincia:"",
		canton:"",
		distrito:"",
		detalle:""
	};
	console.log("entro");
    $scope.getTours=function getTours(){
        OperationsTours.getTours(function(res){
		  $scope.listaTours=res;
	});
	}

	$scope.getTours();
});


/*'use strict'

	};
	$scope.getEstudiantes();

	$scope.putEstudiante = function putEstudiante(estudiante) {

		OperationsStudents.putStudents($scope.estudiante, function(response) {

			if (response.success) {
				console.log("exito");
				//$scope.listaStudents.push(estudiante);
			    $location.path('estudiantes');
			    $route.reload();
			}

		});
	};
	$scope.delete=function deleteEstudiantes(id){
		console.log("imprime:"+id);
		OperationsStudents.deleteStudents(id,function(response){
				if(response.success){
				    $location.path('estudiantes');
				    $route.reload();
				}
		});

	};
	$scope.postEstudiante = function postEstudiante(estudiante) {
		console.log(estudiante);
		OperationsStudents.updateStudents($scope.estudiante, function(response) {

			if (response.success) {
				console.log("exito");
				//$scope.listaStudents.push(estudiante);
			    $location.path('estudiantes');
			    $route.reload();
			}

		});
	};

});*/