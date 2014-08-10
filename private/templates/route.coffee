ReplaceFirstUpperCaseController = RouteController.extend
    template: 'ReplaceFirst'


Router.map ->
    @route 'ReplaceFirst',
        path :  'ReplaceSecond'
        controller :  ReplaceFirstUpperCaseController

    return
