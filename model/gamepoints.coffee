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

    groupId:
      type: String
      label: "group id"
      optional: true

    playerName:
      type: String
      label: "Player name"
      optional: false

    points:
      type: Number
      label: "points"
      optional: false

    rank:
      type: Number
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
  removeGamePoints: (gameId) ->

    console.log 'Remove'
    console.log gameId
    user = Meteor.user()

    # ensure the user is logged in
    throw new Meteor.Error(401, "You need to login...") unless user

    id = Gamepoints.remove( { gameId : gameId } )

    console.log id

    return

  getGamePoints: (data) ->


    user = Meteor.user()

    # ensure the user is logged in
    throw new Meteor.Error(401, "You need to login...") unless user

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
    console.log 'DATA'
    console.log data


    games = Games.find({'groupId' : data._id},{reactive:false, sort:{createdAt: 1 }}).fetch()
    console.log 'GAMES'
    console.log games

    # Reset GroupPoints to 1000


    id = GroupPoints.update groupId: data._id, {
        $set: {value: 1000}
      }, multi: true

    console.log 'GRP'
    console.log GroupPoints.find( {groupId: data._id}, {reactive:false} ).fetch()

    console.log 'SET TO 1000'
    console.log id

    for game in games
      console.log 'GAME'
      console.log game

      gamepoints = Gamepoints.find( { gameId: game._id } , { reactive: false } ).fetch()

      console.log "GAMEPOINTSS"
      console.log gamepoints
      players = []



      players.push( { rank : Gamepoints.findOne( { gameId: game._id, playerName: playerName } , { reactive: false } ).rank , id : Meteor.users.findOne( username: playerName )._id, name: playerName } ) for playerName in game.playerNames

      console.log 'PLAYERS'
      console.log players

      gamePointsEntries = []

      console.log "Date!!"
      console.log game.createdAt.toString()

      date = new Date(game.createdAt.toString())
      date = new Date()

      # Get rank




      gamePointsEntries.push( { gamePointsId: Gamepoints.findOne( { gameId: game._id, playerName: player.name } , { reactive: false } )._id , createdAt: date, rank: player.rank, playerId: player.id, points: 0, gameId: game._id, groupId: game.groupId ,playerName: player.name , groupPointsEntry: GroupPoints.findOne({groupId: game.groupId, playerId: player.id}, {reactive:false}) }) for player in players


      console.log "GamePoints"
      console.log gamePointsEntries
      # Calculate Delta


      if game.type
        console.log "FOR------------------------"
        for playerA in gamePointsEntries

          for playerB in gamePointsEntries
            # console.log "Group Id"
            # console.log game.groupId
            # console.log playerB.id

            # console.log "Player B"
            # console.log playerB
            delta = 0
            # console.log "Player A bf change: "
            #console.log playerA
            #console.log "Player B bf change: "
            #console.log playerB
            console.log 'PLAYER A'
            console.log playerA
            console.log 'PLAYER B'
            console.log playerB
            if playerA.rank < playerB.rank
              delta = computeChange playerA.groupPointsEntry.value, playerB.groupPointsEntry.value
              console.log "Change A: " + delta
              changePlayer =
                groupPointsId: playerA.groupPointsEntry._id
                delta: delta
              playerA.points += delta
              Meteor.call 'updateDartsGroupPoints', changePlayer
              changePlayer =
                groupPointsId: playerB.groupPointsEntry._id
                delta: -delta
              playerB.points += -delta
              Meteor.call 'updateDartsGroupPoints', changePlayer

        console.log 'END'
        console.log gamePointsEntries

        for gamePointEntry in gamePointsEntries

          id =  Gamepoints.update _id: gamePointEntry.gamePointsId,
            $set: gamePointEntry
          console.log id

  updateGamePoints: (gameAttr) ->


    # console.log gameAttr

    user = Meteor.user()

    # ensure the user is logged in
    throw new Meteor.Error(401, "You need to login...") unless user



    players = []

    console.log "Game Attr"
    console.log gameAttr


    players.push( { rank : gameAttr[playerName], id : Meteor.users.findOne( username: playerName )._id, name: playerName } ) for playerName in gameAttr.playerNames

    # console.log players

    gamePointsEntries = []

    console.log "Date!!"
    console.log gameAttr.date.toString()
    console.log new Date("Sat Aug 03 2014 11:27:29 GMT+0200 (CEST)")

    date = new Date(gameAttr.date.toString())
    date = new Date() unless date

    # Add Zero Points for everyone for this game
    group = Groups.findOne( { _id: gameAttr.groupId }, {reactive:false} )
    console.log 'GROUP'
    console.log group
    playerIds = group.playerIds

    gamePlayerIds = _.map players, (o) ->
      o.id

    console.log 'PID'
    console.log gamePlayerIds
    playerIds = _.difference playerIds, gamePlayerIds
    console.log 'DIFF'
    console.log playerIds

    gamePointsEntries.push( { createdAt: date, rank: player.rank, playerId: player.id, points: 0, gameId: gameAttr.gameId, groupId: gameAttr.groupId , playerName: player.name, groupPointsEntry: GroupPoints.findOne( groupId: gameAttr.groupId, playerId: player.id) },  { reactive: false } ) for player in players

    Gamepoints.insert({createdAt: date, rank: -1, playerId: player.id, points: 0, gameId: gameAttr.gameId, groupId: gameAttr.groupId , playerName:  Meteor.users.findOne( _id: playerId ).username}) for playerId in playerIds


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




    if gameAttr.gameType
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
  k1 - Math.round k1 * computeExpectation playerA, playerB

computeExpectation = (playerA, playerB) ->
  console.log "computeExpectation"
  1 / ( 1 + Math.pow( 10, (playerB - playerA) / k2 ) )
