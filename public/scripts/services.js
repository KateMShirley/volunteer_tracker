var services = angular.module('volunteerTrack.services', ['ngResource']);

//FOR CRUD FUNCTIONALITY THAT DOES NOT REQUIRE ID
services.factory('OppsFactory', function($resource){
  return $resource('/api/opportunities', {}, {
    query: { method: 'GET', isArray: true} ,
    create: { method: 'POST' }
  })
});

//FOR CRUD FUNCTIONALITY THAT DOES NOT REQUIRE ID
services.factory('OppFactory', function($resource){
  return $resource('/api/opportunities/:id', {}, {
    show: { method: 'GET' },
    update: { method: 'PUT', params: {id: '@id'} },
    delete: { method: 'DELETE', params: {id: '@id'} }

  })
});
