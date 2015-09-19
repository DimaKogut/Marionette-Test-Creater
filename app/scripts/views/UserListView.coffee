UserView = require './UserView'

module.exports = class UserListView extends Marionette.LayoutView

  className: 'content_inner_block'
  template: require './templates/user_list'

  regions:
    list: '#list'

  onShow: ->
    @list.show new UserView()


