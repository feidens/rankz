# NProgress.configure({ showSpinner: false })

Router.configure
  layoutTemplate: 'basicLayout'
  loadingTemplate: 'loading'
  notFoundTemplate: 'notFound'


requireLogin = (pause) ->
  unless Meteor.userId()
    Router.go 'atSignIn'
  else
    @next()
  return



Router.onBeforeAction 'loading'
Router.onBeforeAction(requireLogin, {only: ['groups', 'games', 'profile', 'rank', 'rankShow', 'gameShow']})
