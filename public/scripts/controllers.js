var app = angular.module('volunteerTrack.controllers', []);

app.controller('OppsCtrl', ['$scope', 'OppsFactory', 'OppFactory', '$location',
    function ($scope, OppsFactory, OppFactory, $location) {
        console.log('ANGULAR IN DA HOUSE');

        $scope.fetch = function() {

          setTimeout(function() {
            $scope.opps = OppsFactory.query();
          }, 1000);

        };

        // callback for ng-click 'editOpp':
        $scope.editOpp = function (oppId) {
            $location.path('/opp_edit/' + oppId);
        };

        // callback for ng-click 'deleteOpp':
        $scope.deleteOpp = function (oppId) {
            OppFactory.delete({ id: oppId });
            $scope.opps = OppsFactory.query();
        };

        // callback for ng-click 'createOpp':
        $scope.createNewOpp = function (opp) {
            // OppsFactory.create($scope.opp);
            // console.log('opp created');
            // console.log ($scope.opp);
            $scope.opp['user_id'] = user.id;
            OppsFactory.save($scope.opp);
            $scope.fetch();
        }

        $scope.opps = OppsFactory.query();
        $scope.currentUser = user.id;
        console.log($scope.currentUser)
        console.log($scope.opps)
    }]);
    /* ... */
    app.controller('OppsEditCtrl', ['$scope', '$routeParams', 'OppFactory', '$location',
        function ($scope, $routeParams, OppFactory, $location) {

            // callback for ng-click 'updateOpp':
            $scope.updateOpp = function () {
                OppFactory.update($scope.opp);
                $location.path('/opps_list');
            };

            // callback for ng-click 'cancel':
            $scope.cancel = function () {
                $location.path('/opps_list');
            };

            $scope.opp = OppFactory.show({id: $routeParams.id});
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
