Marionette.Behaviors.behaviorsLookup = ->
  window.Behaviors

window.Behaviors = {}
window.Behaviors.Closeable = require './behaviors/Closeable'
window.Behaviors.ToolTip = require './behaviors/ToolTip'
window.Behaviors.SortAction = require './behaviors/SortAction'

ToggleableRegion = require './regions/ToggleableRegion'
AppView = require './views/AppView'
TodoModule = require('./modules/todo/TodoModule')

ContentModule = require './modules/ContentModules'

DataJson = require './data/category.json'
TestData = require './data/test'
UsersData = require './data/users'
ActivityData = require './data/activity'

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