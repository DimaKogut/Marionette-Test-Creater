module.exports = class ContentRouter extends Backbone.Marionette.AppRouter

  appRoutes:
    'test_create' : 'testCreateShow'
    'test_list'   : 'testListShow'
    'user_list'   : 'userListShow'
    'test/(:id)'  : 'testStartShow'