Template["gameShow"].helpers
  ownDoc: ->
    @userId is Meteor.userId()
  print: ->
    console.log "Game print"
    console.log @game
    console.log "GamePoints print"
    console.log @gamePoints


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


    data = SimpleForm.processForm(event.target)

    console.log "Submit Show game"
    console.log event
    console.log event.target

    console.log "this"
    console.log @


    data.playerNames = @game.playerNames

    data.gameId = @game._id
    data.groupId = @game.groupId

    console.log data

    Meteor.call('updateGamePoints', data, (error, id) ->
        if error
          # display the error to the user
          #Errors.throw(error.reason);
          if (error.error == 302)
            console.log("error")
           #Router.go('postPage', {_id: error.details});
        else
          console.log(id)
      )

    $("input[id='submitAddGroup']").transition('slide down')
    Session.set('triggered', true)

    return
