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
