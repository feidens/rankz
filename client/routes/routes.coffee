cachedSubs = new SubsManager(
  cacheLimit: 10
  expireIn: 9999
)

# #########
# Profile

ProfileController = RouteController.extend
  template: 'profile'
  # waitOn: ->
  #   cachedSubs.subscribe "playerGroups"
  #   cachedSubs.subscribe "groupPoints"
  # playerGroups: ->
  #   Groups.find {},
  #     playerIds:
  #       $in: [Meteor.userId()]
  #
  #     sort:
  #       createdAt: -1
  #       _id: -1


  data: ->
    { profile: Meteor.users.findOne(Meteor.userId()).profile }



Router.map () ->
    @route 'profile',
        path :  '/profile'
        controller :  ProfileController
    return

# #########
# Games

GamesController = RouteController.extend
  template: 'games'
  waitOn: ->
    [
      cachedSubs.subscribe 'playerGames'
      cachedSubs.subscribe "playerGroups"
    ]

  games: ->
     Games.find {}, {sort: {createdAt: -1, _id: -1}}
  data: ->
    games: @games()

Router.map ->
  @route "games",
    path: "/games"
    controller: GamesController

  return

# #####
# Game Show

GameShowController = RouteController.extend
    template: 'gameShow'
    waitOn: ->
      [
        Meteor.subscribe "gamepoints", @params._id
        Meteor.subscribe "playerGames"
      ]
    game: ->
      gameId = this.params._id
      Games.findOne
        _id: gameId

    gPoints: ->
      gid = this.params._id
      query = Gamepoints.find {},
        sort:
          rank: +1



      query if query.count()

    data: ->
      {game:  @game(), gamePoints: @gPoints() }




Router.map ->
    @route 'gameShow',
        path :  '/games/:_id'
        controller :  GameShowController

    return



# #####
#  Groups List

GroupsListController = RouteController.extend
    template: 'groupsList'
    waitOn: ->
      Meteor.subscribe "playerGroups"
      Meteor.subscribe "groupPoints"
    playerGroups: ->
      Groups.find {},
        playerIds:
          $in: [Meteor.userId()]

        sort:
          createdAt: -1
          _id: -1
    groupPoints: ->
      GroupPoints.find {},
        playerId: Meteor.userId()

        sort:
          createdAt: -1
          _id: -1


    data: ->
        {playerGroups:  @playerGroups().fetch(), groupPoints: @groupPoints().fetch() }



Router.map ->
    @route 'groups',
        path :  '/groups'
        controller :  GroupsListController

    return
