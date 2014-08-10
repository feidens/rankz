Meteor.startup ->
  if Meteor.isClient
    if Meteor.user()
      language = Meteor.user().profile.language  # see step 6.

    else
      # detect the language used by the browser
      language = window.navigator.userLanguage || window.navigator.language
      language = getLanguage language

    i18n.setLanguage language
    moment.lang i18n.getLanguage()
