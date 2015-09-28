Marionette.Behaviors.behaviorsLookup = ->
  window.Behaviors

window.Behaviors = {}
window.Behaviors.Closeable = require './behaviors/Closeable'

ToggleableRegion = require './regions/ToggleableRegion'
AppView = require './views/AppView'
TodoModule = require('./modules/todo/TodoModule')

ContentModule = require './modules/ContentModules'

DataJson = require './data/category.json'
TestData = require './data/test'
UsersData = require './data/users'

class App extends Backbone.Marionette.Application
  initialize: =>
    console.log 'Initializing app...'

    # @router = new Router()

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

    # @module('Todo', TodoModule)
    @module 'Content', ContentModule

    @start()

module.exports = new App()
