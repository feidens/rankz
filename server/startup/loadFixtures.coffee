loadFixture = (fixtures) ->
  i = undefined
  i = 0
  while i < fixtures.length

    # Define your Meteor.method for inserting into the collection under /model
    Meteor.call "", fixtures[i]
    i += 1
  return
Meteor.startup ->
    


  return
