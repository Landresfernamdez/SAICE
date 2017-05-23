angular.module('userModule',['ngRoute'])
.config(['$routeProvider',function($routeProvider)
    {
        $routeProvider

                    .when("/",{
                    	templateUrl:'index.html',
                    	controller: 'mainController'

                    })
                    .when("/estudiantes",{
                        templateUrl:'app/components/estudiantes/estudiantes.html',
                        controller: 'estudiantesController'
                                             })
                    .when("/Giras",{
                        templateUrl:'app/components/Giras/Giras.html',
                        controller: 'GirasController'
                                             })
			        .otherwise({
			            redirectTo: '/'
			        });
    }
]);