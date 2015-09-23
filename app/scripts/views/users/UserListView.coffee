UserView = require './UserView'

module.exports = class UserListView extends Marionette.LayoutView

  className: 'content_inner_block'
  template: require './templates/user_list'

  regions:
    list: '#list'

  initialize: ->
    $('.navigator_active').removeClass 'navigator_active'
    $('#user_list').addClass 'navigator_active'

  onShow: ->
    @list.show new UserView()


