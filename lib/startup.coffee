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
]
AccountsTemplates.removeField 'password'
AccountsTemplates.addField {
    _id: 'password',
    type: 'password',
    placeholder: {
        signUp: "At least six characters"
    },
    required: true,
    minLength: 6,
    re: /(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,}/,
    errStr: 'At least 1 digit, 1 lowercase and 1 uppercase',
}
