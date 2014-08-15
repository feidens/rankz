players = []
playerDep = new Deps.Dependency

Template["rankShow"].helpers
  ownDoc: ->
    @userId is Meteor.userId()

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
            players.push( {username: elem.username, value: elem.value} )

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
