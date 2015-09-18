ContentView = require '../views/ContentView'

module.exports = class ToggleableRegion extends Backbone.Marionette.Region
  initialize: (options) ->
    console.log 'sdsds'
    # @module = options.module
    # @module.region = @

    @initShow()

  initShow: ->
    @emptyView = new ContentView()
    @show(@emptyView)
    @emptyView.on 'resizes', ->        # it's my prytty example, how event triggers works
      console.log 'it"s clicked'
    App.vent.on 'new:click', (data) ->  # it's my prytty example, how function triggers works
      console.log data

  onShow: (view) ->
    @listenTo view, 'region:on', =>
      @module.start()

    @listenTo view, 'region:off', =>
      @module.stop()
      @initShow()