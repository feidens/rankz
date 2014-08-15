Meteor.publish 'groupPoints', ->
  GroupPoints.find playerId: @userId


Meteor.publish 'groupPointsById', (groupPointsId) ->
  GroupPoints.find groupId: groupPointsId
