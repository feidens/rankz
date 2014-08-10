Template["games"].helpers
  ownDoc: ->
    @userId is Meteor.userId()


  gamesWithRank: ->

    @games.rewind()
    @games.map (games, index, cursor) ->
      games._rank = index
      games

  getStatusIconClass: ->

    iconClass = "lab"
    iconClass = "checkmark green" if @status is 2
    iconClass = "ban circle red" if @status is 0
    iconClass = "question purple" if @status is 1
    iconClass

  date: ->
    date = moment(@.createdAt).format("dddd, M-D-YYYY, h:mm:ss a");


  isAFit: ->
    return true if @status is 2



Template["games"].events
  



Template["games"].rendered = ->
  $('.ui.selection.dropdown')
    .dropdown()
