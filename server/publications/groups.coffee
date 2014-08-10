Meteor.publish 'playerGroups', ->
  Groups.find playerIds:
      $in: [ @userId ]
