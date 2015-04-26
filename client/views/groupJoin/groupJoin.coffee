Template["groupJoin"].helpers
  ownDoc: ->
    @userId is Meteor.userId()


Template["groupJoin"].events
  "keyup input[id='joinGroupName']": () ->

    triggered = Session.get('triggeredJoinGroup')
    $("input[id='submitJoinGroup']").transition('slide down') if triggered
    triggered = false if triggered
    Session.set('triggeredJoinGroup', triggered)

  "submit form": (e) ->

    e.preventDefault()


    data = SimpleForm.processForm(e.target)



    Meteor.call('joinGroup', data, (error, id) ->
        if error
          # display the error to the user
          #Errors.throw(error.reason);
          if (error.error == 302)
            console.log("error")
           #Router.go('postPage', {_id: error.details});
        else
          console.log(id)
      )

    $("input[id='submitJoinGroup']").transition('slide down')
    Session.set('triggeredJoinGroup', true)

    return


Template["groupJoin"].rendered = ->
  Session.set('triggeredJoinGroup', true)

  $('.ui.selection.dropdown')
    .dropdown()
