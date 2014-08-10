cachedSubs = new SubsManager(
  cacheLimit: 10
  expireIn: 9999
)

# #########
# Profile

ProfileController = RouteController.extend
  template: 'profile'
  waitOn: ->
    cachedSubs.subscribe "playerGroups"
    cachedSubs.subscribe "groupPoints"
  playerGroups: ->
    Groups.find {},
      playerIds:
        $in: [Meteor.userId()]

      sort:
        createdAt: -1
        _id: -1


  data: ->
    {playerGroups:  @playerGroups(), profile: Meteor.users.findOne(Meteor.userId()).profile }



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
        cachedSubs.subscribe "gamepoints", @params._id
        cachedSubs.subscribe "playerGames"
      ]
    game: ->
      gameId = this.params._id
      Games.findOne
        _id: gameId
      ,
        sort:
          createdAt: -1
          _id: -1
    gPoints: ->
      gid = this.params._id
      query = Gamepoints.find gameId: gid
      query if query.count()

    data: ->
      {game:  @game(), gamePoints: @gPoints() }




Router.map ->
    @route 'gameShow',
        path :  '/games/:_id'
        controller :  GameShowController

    return
