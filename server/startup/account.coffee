Meteor.startup ->
  AccountsEntry.config
    wrapLinks: false
    # signupCode: 'hackdichselbst'         # only restricts username+password users, not OAuth
    defaultProfile:
      language: i18n.getLanguage()
