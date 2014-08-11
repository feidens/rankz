Meteor.startup ->
  AccountsEntry.config
    language: 'de'
    logo: '/public/images/background/background1.jpg'
    privacyUrl: '/privacy-policy'
    termsUrl: '/terms-of-use'
    homeRoute: '/groups'
    dashboardRoute: '/groups'
    profileRoute: '/profile'
    passwordSignupFields: 'USERNAME_ONLY'
    showSignupCode: false
    wrapLinks: false
    showOtherLoginServices: false
    defaultProfile:
      language: i18n.getLanguage()
    # extraSignUpFields: [{
    #     field: "name" # The database property you want to store the data in
    #     name: "" # An initial value for the field, if you want one
    #     label: "Full Name" # The html lable for the field
    #     placeholder: "John Doe" # A placeholder for the field
    #     type: "text" # The type of field you want
    #     required: true # Adds html 5 required property if true
    #     }]
  FastClick.attach(document.body)


  # before: ->
  #   AccountsEntry.signInRequired(@)


#
# @cordova = new Cordova(plugins:
#   notification: true # If we have both native plugins installed
# )
