Meteor.publish 'groupPoints', ->
  GroupPoints.find playerIds:
      $in: [ @userId ]
