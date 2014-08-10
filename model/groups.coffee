@Groups = new Meteor.Collection("groups",
  schema:
    playerIds:
      type: [String]
      label: "member ids"
      optional: true

    playerNames:
      type: [String]
      label: "member names"
      optional: true

    groupname:
      type: String
      label: "Group name"
      optional: false
      unique: true

    avatar:
      type: [String]
      label: "Group avatar"
      optional: true

    createdAt:
      type: Date
      optional: false
)

# Collection2 already does schema checking"
# Add custom permission rules if needed"
Groups.allow
  insert: ->
    false

  update: ->
    true

  remove: ->
    false



Meteor.methods
  joinGroup: (groupAttr) ->
    user = Meteor.user()

    # ensure the user is logged in
    throw new Meteor.Error(401, "You need to login to post new stories") unless user

    group = Groups.findOne groupname: groupAttr.groupname



    Groups.update
      _id: group._id
    ,
      $addToSet:
        playerIds: user._id
        playerNames: user.username

    return

  insertGroup: (groupAttr) ->

    user = Meteor.user()

    # ensure the user is logged in
    throw new Meteor.Error(401, "You need to login to post new stories") unless user


    console.log(groupAttr)
    # pick out the whitelisted keys
    group = _.extend(groupAttr,
      createdAt: new Date()

    )
    groupId = Groups.insert(group)

    console.log "pp1p"
    Groups.update
      _id: groupId
    ,
      $addToSet:
        playerIds: user._id
        playerNames: user.username

    console.log "pp2p"

    groupPointsElem =
      groupId: groupId

    console.log "pp3p"

    Meteor.call 'insertGroupPoints', groupPointsElem

    return
