players = []
playerDep = new Deps.Dependency

Template["rankShow"].helpers
  ownDoc: ->
    @userId is Meteor.userId()
  print: ->


    console.log 'PRINT IN RANK'
    console.log @

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
                reactive: false


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

  grpPoints = GroupPoints.find( { groupId:   @data.group._id }, {fields:{playerName:1} } ).fetch()
  console.log 'GRP POINTS'
  console.log grpPoints
  pointList = []
  for player in grpPoints
    gamepoints = Gamepoints.find( { groupId: @data.group._id, playerName: player.playerName  } , { reactive: false } ).fetch()
    console.log gamepoints

    y = 1000
    x = 1
    Y = []
    Y.push {x : x , y : y}


    for gamepointEntry in gamepoints
      console.log gamepointEntry
      y = y + gamepointEntry.points
      x = x + 1
      Y.push {x : x , y : y}

    console.log Y
    pointList.push {values: Y, key: player.playerName}

  console.log 'Point List'
  console.log pointList

  chart = nv.models.lineChart().margin(left: 100).useInteractiveGuideline(true).transitionDuration(350).showLegend(true).showYAxis(true).showXAxis(true)
  nv.addGraph ->
    chart.xAxis.axisLabel('Game').tickFormat d3.format('d')
    chart.yAxis.axisLabel('Points').tickFormat d3.format('d')





    d3.select('#chart svg').datum( pointList ).call chart
    nv.utils.windowResize ->
      chart.update()
      return
    chart
