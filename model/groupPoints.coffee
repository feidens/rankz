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


    # ensure the user is logged in
    throw new Meteor.Error(401, "You need to login...") unless user


    count = GroupPoints.find( { $and: [ {playerId: user._id}, {groupId: groupPointsElem.groupId} ] } ).count()



    throw new Meteor.Error(300, "This user has already group points") if count

    groupPointsElem.createdAt = new Date()
    groupPointsElem.value = 1000
    groupPointsElem.playerId = user._id

    console.log "pp3p"

    pGPId = GroupPoints.insert(groupPointsElem)


    return

  updateDartsGroupPoints: (changePlayer) ->
    #GroupPoints.groupPointsElem
    console.log "updateDartsGroupPoints"
    console.log changePlayer
    GroupPoints.update( { _id: changePlayer.groupPointsId }, { $inc: { value: changePlayer.delta } })

    return
