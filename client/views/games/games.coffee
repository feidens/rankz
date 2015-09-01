Template["games"].helpers
  ownDoc: ->
    @userId is Meteor.userId()


  gamesWithRank: ->

    @games.rewind()
    @games.map (games, index, cursor) ->
      games._rank = index
      games

  getStatusIconClass: ->

    iconClass = "bullseye"
    iconClass = "checkmark green" if @status is 2
    iconClass = "ban circle red" if @status is 0
    iconClass = "question purple" if @status is 1
    iconClass

  date: ->
    date = moment(@.createdAt).format("dddd, M-D-YYYY, h:mm:ss a");


  isAFit: ->
    return true if @status is 2

  isAdmin: ->
    console.log 'isAdmin'
    console.log @
    group = Groups.findOne @groupId
    console.log group
    Meteor.userId() == group.adminId

  getGroup: ->
    console.log 'Get Group'
    Groups.findOne( @groupId ).groupname




Template["games"].events
  "click #trash": (e, f) ->
    console.log 'Wooooot'
    console.log @
    console.log  Games.remove _id : @._id


    Meteor.call('removeGamePoints', @._id, (error, id) ->
        if error
          # display the error to the user
          #Errors.throw(error.reason);
          if (error.error == 302)
            console.log("error")
           #Router.go('postPage', {_id: error.details});
        else
          console.log(id)
      )


    Meteor.call('getGamePoints', @groupId, (error, id) ->
        if error
          # display the error to the user
          #Errors.throw(error.reason);
          if (error.error == 302)
            console.log("error")
           #Router.go('postPage', {_id: error.details});
        else
          console.log(id)
      )


    return


Template["games"].rendered = ->
  $('.ui.selection.dropdown')
    .dropdown()
