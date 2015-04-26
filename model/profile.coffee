# Meteor.users.deny update: (userId, data, fieldNames) ->
#
#   # may only edit the following these fields:
#   _.without(fieldNames, "profile").length > 0
#



Meteor.methods
  getUserName: (data) ->
    console.log "SERVER SIDE"
    console.log Meteor.users
    name = Meteor.users.findOne( _id: data.playerId ).username
    elem =
      username: name
      value: data.value
    return elem
