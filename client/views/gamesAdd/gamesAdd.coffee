
player: []
playerNames = []
playerDep = new Deps.Dependency

Template["gamesAdd"].helpers
  ownDoc: ->
    @userId is Meteor.userId()
  player: ->
    playerDep.depend()
    return @player
  getDate: ->
    moment(new Date())


Template["gamesAdd"].events
  "click input[value='Submit']": (e) ->
    $("input[value='Submit']").transition('pulse')

  "click input[type='checkbox']": (e) ->
    console.log "Before Check"
    console.log playerNames

    playerNames.push(e.target.value) if e.target.checked
    playerNames = _.without(playerNames, e.target.value) unless e.target.checked

    playerNames = _.uniq(playerNames);

    console.log "After check"
    console.log playerNames





  "keyup input[id='groupName']": () ->


    groupname = $("input[id='groupName']").val()
    console.log groupname
    group = Groups.findOne( groupname:
      groupname
    )
    console.log group
    console.log group.playerNames if group


    @player = group.playerNames if group
    @player = [] unless group
    console.log @player
    playerDep.changed()
    return

  "submit form": (e, template) ->

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

    data.playerNames = playerNames
    console.log 'DATA'
    console.log data


    data.date =  data.range
    console.log 'DATA'
    data.date = new Date(data.daterange)
    # data.date = template.picker.getMoment().toDate()

    console.log "Submit game add data"
    console.log data
    if data.playerNames.length > 1
      Meteor.call('createGame', data, (error, id) ->
          if error
            # display the error to the user
            #Errors.throw(error.reason);
            if (error.error == 302)
              console.log("error")
             #Router.go('postPage', {_id: error.details});
          else
            console.log "GOOOO"
            Router.go('gameShow', {_id: id});
        )

    $("input[id='submitAddGroup']").transition('slide down')
    Session.set('triggered', true)

    return



Template["gamesAdd"].rendered = ->
  $(document).ready ->
    console.log 'ready'
    $('input[name="daterange"]').daterangepicker {
      format: 'YYYY-MM-DDTHH:MM:SS'
      startDate: moment(new Date())
      timePicker: true
      singleDatePicker: true
      timePicker12Hour: false
    }
    return


  player = []
  playerNames = []
  console.log @
  # @picker = new Pikaday(
  #   field: document.getElementById('datepicker')
  #   format: 'dddd, DD.MM.YYYY'
  #   defaultDate: moment(new Date()).format('dddd, DD.MM.YYYY')
  #   setDefaultDate: true
  #   onSelect: ->
  #     console.log this
  #     console.log this.getMoment().format('dddd, DD.MM.YYYY')
  #     return
  # )
  console.log @
