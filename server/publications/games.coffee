Meteor.publish 'playerGames', ->
  groups = Groups.find
    playerIds:
      $in: [ @userId ]
    ,
      fields:
        _id: true

  console.log "GGG"
  ids = groups.fetch()
  console.log ids

  ids = _.map(ids, (value, index) ->
    return value._id;
  )

  console.log ids


  Games.find
    groupId:
      $in:
        ids
    ,
      sort:
        createdAt: -1
        _id: -1


Meteor.publish 'games', (gameId) ->
  Games.find
    _id: gameId
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
