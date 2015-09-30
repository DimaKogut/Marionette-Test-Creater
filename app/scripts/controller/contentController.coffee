TestCreateView = require '../views/test_create/TestCreateView'
TestListView = require '../views/test_list/TestListView'
UserListView = require '../views/users/UserListView'
TestStartView = require '../views/test_start/TestStartView'

Collection = Backbone.Collection.extend({})

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

  testStartShow: (viewType) ->
    n = new Collection()
    n.push TestData
    n = n.where id: viewType
    view = new TestStartView data: n[0], viewType: viewType
    @mainView.content.show view