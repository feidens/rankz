@GroupPoints = new Meteor.Collection("groupPoints",
  schema:
    playerId:
      type: String
      label: "Player id"
      optional: false

    groupId:
      type: String
      label: "Group id"
      optional: false

    value:
      type: Number
      label: "Point value"
      optional: false

    createdAt:
      type: Date
      optional: false
)

# Collection2 already does schema checking"
# Add custom permission rules if needed"
GroupPoints.allow
  insert: ->
    true

  update: ->
    true

  remove: ->
    true


Meteor.methods
  insertGroupPoints: (groupPointsElem) ->

    user = Meteor.user()

    console.log "ADAWDAWDADADLAWLDLLWA"

    # ensure the user is logged in
    throw new Meteor.Error(401, "You need to login to post new stories") unless user


    console.log(groupPointsElem)
    # pick out the whitelisted keys

    groupPointsElem.createdAt = new Date()
    groupPointsElem.value = 1200
    groupPointsElem.playerId = user._id

    console.log "pp3p"

    pGPId = GroupPoints.insert(groupPointsElem)

    console.log "pp4p"

    console.log pGPId

    return
