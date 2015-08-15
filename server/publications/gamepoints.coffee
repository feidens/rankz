Meteor.publish 'gamepoints', (gameId) ->
  Gamepoints.find gameId: gameId


Meteor.publish 'gamepointsByGroup', (groupId) ->
  Gamepoints.find groupId: groupId
