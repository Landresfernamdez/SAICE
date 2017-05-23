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

                    .when("/funcionarios",{
                        templateUrl:'app/components/funcionarios/funcionarios.html',
                        controller: 'funcionariosController'
                                             })
                    .when("/contactos",{
                        templateUrl:'app/components/contactos/contactos.html',
                        controller: 'contactosController'
                                             })

			        .otherwise({
			            redirectTo: '/'
			        });
    }
]);