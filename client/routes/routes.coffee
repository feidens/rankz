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
  userProfile: ->
    console.log Meteor.users
    console.log Meteor.userId()
    Meteor.users.findOne()

  data: ->
    @userProfile()



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
      Meteor.subscribe 'playerGames'
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
        Meteor.subscribe "games", @params._id
      ]
    game: ->
      gameId = this.params._id
      Games.findOne
        _id: gameId

    gPoints: ->
      gid = this.params._id
      query = Gamepoints.find { },
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

Router.map ->
    @route 'home',
        path :  '/'

    return


# #####
#  Rank List

RankListController = RouteController.extend
    template: 'rankList'
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
    @route 'rank',
        path :  '/rank'
        controller :  RankListController

    return


# #####
# Rank Show

RankShowController  = RouteController.extend
    template: 'rankShow'
    waitOn: ->
      [
        Meteor.subscribe "groupPointsById", @params._id
        Meteor.subscribe "playerGroups"
        Meteor.subscribe "gamepointsByGroup", @params._id
        Meteor.subscribe "groupPlayerGames", @params._id
      ]
    group: ->
      groupId = @params._id
      Groups.findOne
        _id: groupId

    groupPoints: ->
      gid = this.params._id
      query = GroupPoints.find {},
        sort:
          value: -1
      query if query.count()

    groupPlayerGames: ->
      groupId = this.params._id
      Games.find
        groupId: groupId

    data: ->
      { group:  @group(), groupPoints: @groupPoints(), groupPlayerGames: @groupPlayerGames() }




Router.map ->
    @route 'rankShow',
        path :  '/rank/:_id'
        controller :  RankShowController

    return
