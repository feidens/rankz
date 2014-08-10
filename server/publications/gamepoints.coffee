Meteor.publish 'gamepoints', (gameId) ->
  Gamepoints.find gameId: gameId
