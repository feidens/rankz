Meteor.publish 'playerGames', ->
  Games.find
    playerIds:
      $in: [
        @userId
        ]
    ,
      sort:
        createdAt: -1
        _id: -1


Meteor.publish 'groupPlayerGames', (groupId) ->
  Games.find
    playerIds:
      $in: [
        @userId
        ]
    ,
    groupId: groupId
    ,
      sort:
        createdAt: -1
        _id: -1
