Template["gameShow"].helpers
  ownDoc: ->
    @userId is Meteor.userId()
  print: ->
    console.log "Game print"
    console.log @game
    console.log "GamePoints print"
    console.log @gamePoints
  printThis: ->
    console.log "Print this"
    console.log @
  getPoints:->
    data = {}
    data._id = @game.groupId
    console.log 'GET POINTS IN SHOW'
    Meteor.call('getGamePoints', data, (error, id) ->
        if error
          # display the error to the user
          #Errors.throw(error.reason);
          if (error.error == 302)
            console.log("error")
           #Router.go('postPage', {_id: error.details});
        else
          console.log(id)
      )



Template["gameShow"].events
  "click input[value='Submit']": (e) ->
    $("input[value='Submit']").transition('pulse')
  "submit form": (e) ->

    e.preventDefault()

    # size_temp = $(e.target).find('[name=size]').val()

    #status_temp = 2 if status_temp is  ""
    # example ={
    #   code: $(e.target).find('[name=code]').val().toLowerCase()
    #   brand: $(e.target).find('[name=brand]').val().toLowerCase()
    #   # .replace(/\s/g,'')
    #   productLine: $(e.target).find('[name=productLine]').val().toLowerCase()
    #   category:  $(e.target).find('[name=category]').val().toLowerCase()
    #   size:  size_temp
    # }


    data = SimpleForm.processForm(e.target)

    console.log "Submit Show game"


    data.playerNames = @game.playerNames

    data.gameId = @game._id
    data.groupId = @game.groupId
    data.gameType = @game.type
    data.date = @game.createdAt


    console.log data

    Meteor.call('updateGamePoints', data, (error, id) ->
        if error
          # display the error to the user
          #Errors.throw(error.reason);
          if (error.error == 302)
            console.log("error")
           #Router.go('postPage', {_id: error.details});
        else
          console.log id
      )

    $("input[id='submitAddGroup']").transition('slide down')
    Session.set('triggered', true)

    return
