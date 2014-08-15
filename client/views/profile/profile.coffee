Template["profile"].helpers
  ownDoc: ->
    @userId is Meteor.userId()
  isDimensionDefined: ->
    tb = Dimensions.find({userId: Meteor.userId()}).count() is 0
  isActive: (elem, data)->
    return "active" if elem is data
  styleText: ->
    return @profile.style if @profile.style
    return i18n "profile.chooseStyle"
  isDefaultStyle: ->
    return "default" unless @profile.style
  genderText: ->
    return i18n "profile.#{@profile.gender}" if @profile.gender
    return i18n "profile.chooseGender"
  isDefaultGender: ->
    return "default" unless @profile.gender
  languageText: ->
    return i18n "profile.#{@.profile.language}" if @profile.language and not Session.get('reloadLanguage')
    return i18n "profile.chooseLanguage" unless Session.get('reloadLanguage')
  isDefaultLanguage: ->
    return "default" unless @profile.language


Template["profile"].events

  "click input[value='Submit']": (e) ->
    $("input[value='Submit']").transition('slide down')
    Session.set('triggered', true)

  "submit form": (e) ->

    e.preventDefault()


    console.log("Profile Input")


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

    Session.set('reloadLanguage', true) if data.language

    data.gender = @profile.gender unless data.gender
    data.style = @profile.style unless data.style
    data.language = @profile.language unless data.language
    i18n.setLanguage(data.language) if data.language

    Meteor.users.update Meteor.userId(),
      $set: {profile: data}


    return

  "change .dropdown": () ->

    triggered = Session.get('triggered')
    $("input[value='Submit']").transition('slide down') if triggered
    triggered = false if triggered
    Session.set('triggered', triggered)

  "keyup input[id='Name']": () ->

    triggered = Session.get('triggered')
    $("input[value='Submit']").transition('slide down') if triggered
    triggered = false if triggered
    Session.set('triggered', triggered)



Template["profile"].rendered = ->
  Session.set('triggered', true)

  $('.ui.selection.dropdown')
    .dropdown()
  

  Session.set('reloadLanguage', false) if Session.get('reloadLanguage')
