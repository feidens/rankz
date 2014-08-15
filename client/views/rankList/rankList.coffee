Template["rankList"].helpers
  ownDoc: ->
    @userId is Meteor.userId()
  playerGroups: ->
    playerGroupsAugmented = []

    for group in @playerGroups
      group.points = _.where(@groupPoints, { groupId: group._id})[0].value

    @playerGroups


Template["rankList"].events
