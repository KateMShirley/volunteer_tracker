angular.module('volunteerTrack.services', []).factory('Opp', function($resource) {
  return $resource('/api/opportunities/:id', { id: '@id' }, {
    update: {
      method: 'PUT'
    }
  });
});
