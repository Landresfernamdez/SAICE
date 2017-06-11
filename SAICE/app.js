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

                    .when("/funcionarios",{
                        templateUrl:'app/components/funcionarios/funcionarios.html',
                        controller: 'funcionariosController'
                                             })
                    .when("/contactos",{
                        templateUrl:'app/components/contactos/contactos.html',
                        controller: 'contactosController'
                                             })

                    .when("/eventos",{
                        templateUrl:'app/components/eventos/eventos.html',
                        controller: 'eventosController'
                                             })

                    .when("/empresas",{
                        templateUrl:'app/components/empresas/empresas.html',
                        controller:'empresasController'
                                             })
                    .when("/polizas",{
                        templateUrl:'app/components/polizas/polizas.html',
                        controller:'polizasController'
                                             })
                    .when("/practicas",{
                        templateUrl:'app/components/practicas/practicas.html',
                        controller:'practicasController'
                                             })

                    .when("/secciones",{
                        templateUrl:'app/components/secciones/secciones.html',
                        controller:'seccionesController'
                                             })
                    .when("/giras",{
                        templateUrl:'app/components/giras/giras.html',
                        controller:'girasController'
                                             })
                    .when("/girass",{
                    templateUrl:'app/components/girassecciones/girassecciones.html',
                    controller:'girasseccionesController'
                    }).when("/girase",{
                        templateUrl:'app/components/girasempresas/girasempresas.html',
                        controller:'girasempresasController'
                    })
                    .when("/estadisticas",{
                        templateUrl:'app/components/estadisticas/estadisticas1/estadisticas.html',
                        controller:'estadisticasController'
                                             })
                    .when("/estadisticas1",{
                        templateUrl:'app/components/estadisticas/estadisticas2/estadisticas1.html',
                        controller:'estadisticas1Controller'
                                             })
                    .when("/estadisticas2",{
                    templateUrl:'app/components/estadisticas/estadisticas3/estadisticas2.html',
                    controller:'estadisticas2Controller'
                                              })

			        .otherwise({
			            redirectTo: '/'
			        });
    }
]);