var app = angular.module('volunteerTrack', ['ui-router','ngResouce', 'volunteerTrack.controllers', 'volunteerTrack.services'])

// app.config(function($stateProvider) {
//   $stateProvider.state('opps', { // state for showing all opps
//     url: '/users/dashboard',
//     templateUrl: 'partials/movies.html',
//     controller: 'OppsListController'
//   }).state('viewMovie', { //state for showing single movie
//     url: '/movies/:id/view',
//     templateUrl: 'partials/movie-view.html',
//     controller: 'MovieViewController'
//   }).state('newMovie', { //state for adding a new movie
//     url: '/movies/new',
//     templateUrl: 'partials/movie-add.html',
//     controller: 'MovieCreateController'
//   }).state('editMovie', { //state for updating a movie
//     url: '/movies/:id/edit',
//     templateUrl: 'partials/movie-edit.html',
//     controller: 'MovieEditController'
//   });
// }).run(function($state) {
//   $state.go('opps'); //make a transition to movies state when app starts
// });

// .controller('MainCtrl', ['$scope', function($scope){
//   console.log("angular");
//   $scope.message = "ANGULAR IS WORKING";
//
// }])
