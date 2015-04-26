players = []
playerDep = new Deps.Dependency

Template["rankShow"].helpers
  ownDoc: ->
    @userId is Meteor.userId()
  print: ->

    a = Games.find
      playerIds:
        $in: [
          Meteor.userId()
          ]
      ,
        sort:
          createdAt: -1
          _id: -1

    console.log a.count()

    return

  calcPlayers: ->
    players = []


    for groupPointEntry in @groupPoints.fetch()
      Meteor.call 'getUserName', groupPointEntry, (error, elem) ->
          if error
            # display the error to the user
            #Errors.throw(error.reason);
            if (error.error == 302)
              console.log('error')
             #Router.go('postPage', {_id: error.details});
          else
            gamesPlayed = Games.find
              playerIds:
                $in: [
                  elem.playerId
                  ]
              ,
                sort:
                  createdAt: -1
                  _id: -1


            players.push( {username: elem.username, value: elem.value, gamesPlayed: gamesPlayed.count()} )

            playerDep.changed()
            return
    return

  groupPointsAugmented: ->
    @groupPoints.rewind()
    @groupPoints.map (groupPoints, index, cursor) ->
      groupPoints._rank = index
      groupPoints

    playerDep.depend()
    players

Template["rankShow"].events



Template.rankShow.rendered = ->
  players = []
