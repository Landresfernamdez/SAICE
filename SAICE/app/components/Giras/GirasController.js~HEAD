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
    /*Mostrar giras*/
    $scope.getTours=function getTours(){
        OperationsTours.getTours(function(res){
		  $scope.listaTours=res;
	});
	}

	$scope.getTours();

	/*Insertar Giras*/
	$scope.putTours=function putTours(Tours){

		OperationsTours.putTours($scope.Tours,function(response){
		
			if (response.success) {
				console.log("Gira insertada");
				$location.path('Giras');
				route.reload();
			}
		});
	};

});


/*'
$scope.getFuncionarios();
	$scope.putFuncionarios = function putFuncionarios(funcionario) {

		OperationsFuncionarios.putofficials($scope.funcionario, function(response) {

			if (response.success) {
				console.log("exito");
			    $location.path('funcionarios');
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