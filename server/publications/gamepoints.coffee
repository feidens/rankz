Meteor.publish 'gamepoints', (gameId) ->
  Gamepoints.find
    gameId: gameId
    ,
      sort:
        createdAt: -1



Meteor.publish 'gamepointsByGroup', (groupId) ->
  Gamepoints.find
    groupId: groupId
    ,
      sort:
        createdAt: -1
