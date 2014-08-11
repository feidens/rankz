Template["groupsList"].helpers
  ownDoc: ->
    @userId is Meteor.userId()
  print: ->
    console.log "Print this"
    console.log @
  playerGroups: ->
    playerGroupsAugmented = []

    for group in @playerGroups
      group.points = _.where(@groupPoints, { groupId: group._id})[0].value

    @playerGroups

Template["groupsList"].events
