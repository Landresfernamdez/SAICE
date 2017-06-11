angular.module('userModule',['ngRoute','zingchart-angularjs'])
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
<<<<<<< HEAD

                    .when("/funcionarios",{
                        templateUrl:'app/components/funcionarios/funcionarios.html',
                        controller: 'funcionariosController'
                                             })
                    .when("/contactos",{
                        templateUrl:'app/components/contactos/contactos.html',
                        controller: 'contactosController'
                                             })
=======
>>>>>>> ramasergio
                    .when("/Giras",{
                        templateUrl:'app/components/Giras/Giras.html',
                        controller: 'GirasController'
                                             })
<<<<<<< HEAD

                    .when("/eventos",{
                        templateUrl:'app/components/eventos/eventos.html',
                        controller: 'eventosController'
                                             })
                    .when("/estadisticas",{
                        templateUrl:'app/components/estadisticas/estadisticas.html',
                        controller:'estadisticasController'
                                             })
=======
>>>>>>> ramasergio
			        .otherwise({
			            redirectTo: '/'
			        });
    }
]);