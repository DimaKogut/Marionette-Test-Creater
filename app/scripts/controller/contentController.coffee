ContentView = require '../views/ContentView'

module.exports = class ContentController extends Marionette.Controller

  testListShow: ->
    console.log @mainView
    @mainView.content.show new ContentView()

  userListShow: ->

    console.log 'userListShow'