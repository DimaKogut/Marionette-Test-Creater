TestCreateView = require '../views/test_create/TestCreateView'
TestListView = require '../views/test_list/TestListView'
UserListView = require '../views/users/UserListView'

module.exports = class ContentController extends Marionette.Controller

  testCreateShow: ->

    view = new TestCreateView()
    @mainView.content.show view

  testListShow: ->

    view = new TestListView()
    @mainView.content.show view

  userListShow: ->

    view = new UserListView()
    @mainView.content.show view