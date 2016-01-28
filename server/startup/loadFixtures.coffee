loadFixture = (fixtures) ->
  i = undefined
  i = 0
  while i < fixtures.length

    # Define your Meteor.method for inserting into the collection under /model
    Meteor.call "", fixtures[i]
    i += 1
  return
Meteor.startup ->
  console.log "FIX"
  users = Meteor.users.find().fetch()
  console.log users
  for user in users
    console.log Gamepoints.update({playerName: user.username},{ $set: {playerId: user._id} },{multi: true})

  # Gamepoints.update({gameId: game._id, playerId: playerId} , { $set: {createdAt: game.createdAt, rank: -1, playerId: playerId, points: 0, gameId: game._id, groupId: game.groupId , playerName:  Meteor.users.findOne( _id: playerId ).username} }, { upsert: true }) for playerId in playerIds



  return
