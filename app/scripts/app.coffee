Marionette.Behaviors.behaviorsLookup = ->
  window.Behaviors

window.Behaviors = {}
window.Behaviors.Closeable = require './behaviors/Closeable'

ToggleableRegion = require './regions/ToggleableRegion'
AppView = require './views/AppView'
TodoModule = require('./modules/todo/TodoModule')
NotificationModule = require('./modules/notification/NotificationModule')


ContentModule = require './modules/ContentModules'

class App extends Backbone.Marionette.Application
  initialize: =>
    console.log 'Initializing app...'

    # @router = new Router()
    # console.log @router

    @addInitializer( (options) =>
      @baseView = new AppView()
      @baseView.render()
    )

    @addInitializer( (options) =>
      @addRegions({
        contentnRegion: {
          selector: "#content"
          regionClass: ToggleableRegion
        }
      })
    )

    @addInitializer( (options) =>
      Backbone.history.start()
    )

    # @module('Notification', NotificationModule)
    # @module('Todo', TodoModule)
    @module 'Content', ContentModule

    @start()

module.exports = new App()
