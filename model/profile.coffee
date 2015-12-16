# Meteor.users.deny update: (userId, data, fieldNames) ->
#
#   # may only edit the following these fields:
#   _.without(fieldNames, "profile").length > 0
#



Meteor.methods
  getUserName: (data) ->
    name = Meteor.users.findOne( _id: data.playerId, {reactive: false} ).username
    elem =
      username: name
      value: data.value
    return elem
