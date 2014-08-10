@ReplaceFirstUpperCase = new Meteor.Collection("ReplaceFirst",
  schema:
)

# Collection2 already does schema checking"
# Add custom permission rules if needed"
ReplaceFirstUpperCase.allow
  insert: ->
    true

  update: ->
    true

  remove: ->
    true
