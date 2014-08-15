NProgress.configure({ showSpinner: false })

Router.configure
  layoutTemplate: 'basicLayout'
  loadingTemplate: 'loading'
  notFoundTemplate: 'notFound'



requireLogin = (pause) ->
  unless Meteor.user()
    if Meteor.loggingIn()
      @render 'loading'
    else
      @render "accessDenied"
    pause()



Router.onBeforeAction 'loading'
Router.onBeforeAction(requireLogin, {only: ['groups', 'games', 'profile', 'rank', 'rankShow', 'gameShow']})
