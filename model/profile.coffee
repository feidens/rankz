Meteor.users.deny update: (userId, data, fieldNames) ->

  # may only edit the following these fields:
  _.without(fieldNames, "profile").length > 0
