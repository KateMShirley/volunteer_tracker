var app = angular.module('volunteerTrack.controllers', []);

app.controller('OppsCtrl', ['$scope', 'OppsFactory', 'OppsFactory', '$location',
    function ($scope, OppsFactory, OppsFactory, $location) {
        console.log('ANGULAR IN DA HOUSE');

        $scope.fetch = function() {

          setTimeout(function() {
            $scope.opps = OppsFactory.query();
          }, 100);

        };

        // // callback for ng-click 'editOpp':
        // $scope.editOpp = function (oppId) {
        //     $location.path('/opp_edit/' + oppId);
        // };

        // callback for ng-click 'deleteOpp':
        $scope.deleteOpp = function (oppId) {
            OppsFactory.delete({ id: oppId });
            //$scope.opps = OppsFactory.query();
            $scope.fetch();
        };

        // callback for ng-click 'createOpp':
        $scope.createNewOpp = function (opp) {

            $scope.opp['user_id'] = user.id;
            OppsFactory.save($scope.opp);
            $scope.fetch();
        }

        $scope.opps = OppsFactory.query();
        $scope.currentUser = user.id;
        $scope.totalHours = total_hours;
        $scope.all_orgs = all_orgs;
        $scope.all_categs = all_categs;
        console.log($scope.currentUser)
        console.log($scope.opps)

    }]);
    /* ... */
    app.controller('OppsEditCtrl', ['$scope', '$routeParams', 'OppsFactory', '$location',
        function ($scope, $routeParams, OppsFactory, $location) {

            // callback for ng-click 'updateOpp':
            $scope.updateOpp = function () {
                OppsFactory.update($scope.opp);
                $location.path('/opps_list');
            };

            // callback for ng-click 'cancel':
            $scope.cancel = function () {
                $location.path('/opps_list');
            };

            $scope.opp = OppsFactory.show({id: $routeParams.id});
        }]);

    // app.controller('OppsNewCtrl', ['$scope', 'OppsFactory', '$location',
    //     function ($scope, OppsFactory, $location) {
    //
    //         // callback for ng-click 'createNewUser':
    //         $scope.createNewOpp = function () {
    //             OppsFactory.create($scope.opp);
    //
    //         }
    //     }]);
