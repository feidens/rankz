@Games = new Meteor.Collection("games",
  schema:
    groupId:
      type: String
      label: "Group id"
      optional: true

    playerIds:
      type: [String]
      label: "Players"
      optional: false

    playerNames:
      type: [String]
      optional: false

    type: # e.g. darts, chess
      type: String
      label: "Type of game"
      optional: false

    createdAt:
      type: Date
      optional: false
)

# Collection2 already does schema checking"
# Add custom permission rules if needed"
Games.allow
  insert: ->
    true

  update: ->
    true

  remove: ->
    true



Meteor.methods
  createGame: (gameAttr) ->

    user = Meteor.user()

    # ensure the user is logged in
    throw new Meteor.Error(401, "You need to login...") unless user

    group = Groups.findOne groupname: gameAttr.groupname

    playerIds = [];

    playerIds.push(Meteor.users.findOne( username: name )._id) for name in gameAttr.playerNames

    console.log playerIds

    console.log(gameAttr)
    # pick out the whitelisted keys
    game = {
      createdAt: new Date()
      playerNames: gameAttr.playerNames
      type: gameAttr.type
      playerIds: playerIds
      groupId: group._id
    }
    gameId = Games.insert(game)

    return gameId
