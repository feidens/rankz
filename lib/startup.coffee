AccountsTemplates.configure

  # Behaviour
  confirmPassword: true
  enablePasswordChange: false
  forbidClientAccountCreation: false
  overrideLoginErrors: false
  sendVerificationEmail: false

  # Appearance
  showAddRemoveServices: false
  showForgotPasswordLink: true
  showLabels: true
  showPlaceholders: true

  # Client-side Validation
  continuousValidation: true
  negativeFeedback: true
  negativeValidation: true
  positiveValidation: true
  positiveFeedback: true

  # Privacy Policy and Terms of Use
  privacyUrl: "privacy"
  termsUrl: "terms-of-use"

  # Redirects
  homeRoutePath: "fits"
  redirectTimeout: 4000

  # Texts

  texts:
    button:
      changePwd: "Password Text"
      enrollAccount: "Enroll Text"
      forgotPwd: "Forgot Pwd Text"
      resetPwd: "Reset Pwd Text"
      signIn: "Sign In Text"
      signUp: "Sign Up Text"

  texts:
    title:
      changePwd: "Password Title"
      enrollAccount: "Enroll Title"
      forgotPwd: "Forgot Pwd Title"
      resetPwd: "Reset Pwd Title"
      signIn: "Sign in to Fitting"
      signUp: "Sign Up Title"

AccountsTemplates.configureRoute "signIn",
  redirect: "/"

AccountsTemplates.configureRoute "signUp",
  redirect: "/profile"


if Meteor.isServer
  Meteor.methods userExists: (username) ->
    !!Meteor.users.findOne(username: username)




AccountsTemplates.removeField "email"
AccountsTemplates.addFields [
  {
    _id: "username"
    type: "text"
    required: true
    minLength: 3
    func: (value) ->
      if Meteor.isClient
        console.log "Validating username..."
        self = this
        Meteor.call "userExists", value, (err, userExists) ->
          unless userExists
            self.setSuccess()
          else
            self.setError 'Choose another one'
          self.setValidating false
          return

        return

      # Server
      Meteor.call "userExists", value
  }
  {
    _id: "email"
    type: "email"
    required: true
    displayName: "email"
    re: /.+@(.+){2,}\.(.+){2,}/
    errStr: "Invalid email"
  }
  {
    _id: "gender"
    type: "radio"
    required: false
    displayName: "Gender"
    select: [
      {
        text: "Male"
        value: "man"
      }
      {
        text: "Female"
        value: "woman"
      }
    ]
  }
  {
    _id: "style"
    type: "radio"
    required: false
    displayName: "Style"
    select: [
      {
        text: "Normal"
        value: "normal"
      }
      {
        text: "Casual"
        value: "casual"
      }
    ]
  }
]
