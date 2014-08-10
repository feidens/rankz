@Gamepoints = new Meteor.Collection("gamepoints",
  schema:
    gameId:
      type: String
      label: "game id"
      optional: true

    playerId:
      type: String
      label: "player id"
      optional: false

    playerName:
      type: String
      label: "Player name"
      optional: false

    points:
      type: String
      label: "points"
      optional: false
      unique: true

    createdAt:
      type: Date
      optional: false
)

# Collection2 already does schema checking"
# Add custom permission rules if needed"
Gamepoints.allow
  insert: ->
    true

  update: ->
    true

  remove: ->
    true

Meteor.methods
  updateGamePoints: (gameAttr) ->

    # console.log gameAttr

    user = Meteor.user()

    # ensure the user is logged in
    throw new Meteor.Error(401, "You need to login to post new stories") unless user

    # group = Groups.findOne groupname: gameAttr.groupname

    players = []

    players.push( { points : gameAttr[playerName], id : Meteor.users.findOne( username: playerName )._id, name: playerName } ) for playerName in gameAttr.playerNames

    # console.log players

    gamePointsEntries = []

    gamePointsEntries.push( { createdAt: new Date, points: player.points, playerId: player.id, gameId: gameAttr.gameId, playerName: player.name } ) for player in players


    Gamepoints.insert(gamePointEntry) for gamePointEntry in gamePointsEntries

    return
