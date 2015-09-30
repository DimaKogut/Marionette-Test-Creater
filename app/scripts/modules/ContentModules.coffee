ContentRouter = require '../main_router'
ContentController = require '../controller/ContentController'

AppView = require '../views/AppView'

module.exports = class BaseModule extends Marionette.Module

  initialize: ->
    @mainView = new AppView()
    @ContentController = new ContentController
    @ContentController.mainView = @mainView
    @ContentRouter = new ContentRouter { controller: @ContentController }