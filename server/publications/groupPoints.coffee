Meteor.publish 'groupPoints', ->
  GroupPoints.find playerId: @userId
