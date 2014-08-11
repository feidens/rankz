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
      type: Number
      label: "points"
      optional: false

    rank:
      type: String
      label: "rank"
      optional: false

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
    throw new Meteor.Error(401, "You need to login...") unless user

    # group = Groups.findOne groupname: gameAttr.groupname

    players = []

    console.log "Game Attr"
    console.log gameAttr


    players.push( { rank : gameAttr[playerName], id : Meteor.users.findOne( username: playerName )._id, name: playerName } ) for playerName in gameAttr.playerNames

    # console.log players

    gamePointsEntries = []

    gamePointsEntries.push( { createdAt: new Date, rank: player.rank, playerId: player.id, points: 0, gameId: gameAttr.gameId, playerName: player.name, groupPointsEntry: GroupPoints.findOne( groupId: gameAttr.groupId, playerId: player.id) }) for player in players




    # static private int k1 = 25;
    # static private int k2 = 800;
    #
    #
    # private static int computeChange(int rA, int rB) {
    #     return (int) Math.round(k1 * computeExpectation(rA, rB));
    # }
    #
    # private static double computeExpectation(int rA, int rB) {
    #   return 1 / (1 + Math.pow(10, (double)(rB - rA) / k2));
    # }




    if gameAttr.gameType is "darts"
      for playerA in gamePointsEntries

        for playerB in gamePointsEntries
          # console.log "Group Id"
          # console.log gameAttr.groupId
          # console.log playerB.id

          # console.log "Player B"
          # console.log playerBGroupPoints.playerId
          delta = 0
          # console.log "Player A bf change: "
          #console.log playerA
          #console.log "Player B bf change: "
          #console.log playerB
          if playerA.rank < playerB.rank
            delta = computeChange playerA.groupPointsEntry.value, playerB.groupPointsEntry.value
            #console.log "Change A: " + delta
            changePlayer =
              groupPointsId: playerA.groupPointsEntry._id
              delta: delta
            playerA.points += delta
            Meteor.call "updateDartsGroupPoints", changePlayer
            changePlayer =
              groupPointsId: playerB.groupPointsEntry._id
              delta: -delta
            playerB.points += -delta
            Meteor.call "updateDartsGroupPoints", changePlayer

    console.log gamePointsEntries

    Gamepoints.insert(gamePointEntry) for gamePointEntry in gamePointsEntries

    return

k1 = 25
k2 = 800

computeChange = (playerA, playerB) ->
  console.log "computeChange"
  Math.round k1 * computeExpectation playerA, playerB

computeExpectation = (playerA, playerB) ->
  console.log "computeExpectation"
  1 / ( 1 + Math.pow( 10, (playerB - playerA) / k2 ) )
