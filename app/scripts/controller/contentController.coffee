TestCreateView = require '../views/TestCreateView'
UserListView = require '../views/users/UserListView'


module.exports = class ContentController extends Marionette.Controller

  testCreateShow: ->

    view = new TestCreateView()
    @mainView.content.show view

  testListShow: ->

    console.log 'userListShow'

  userListShow: ->

    view = new UserListView()
    @mainView.content.show view