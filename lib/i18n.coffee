i18n.setDefaultLanguage 'de-de'


@getLanguage = (language) ->
  if language.match /en/
    language = 'en-us'

  else
    language = 'de-de'

  return language
