Template['addGroup'].helpers

Template['addGroup'].events
  "keyup input[id='addGroupName']": () ->

    triggered = Session.get('triggeredAddGroup')
    $("input[id='submitAddGroup']").transition('slide down') if triggered
    triggered = false if triggered
    Session.set('triggeredAddGroup', triggered)

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



    Meteor.call('insertGroup', data, (error, id) ->
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
    Session.set('triggeredAddGroup', true)

    return

Template["addGroup"].rendered = ->
  Session.set('triggeredAddGroup', true)
