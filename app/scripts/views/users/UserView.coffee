class UserEmptyList extends Marionette.ItemView

  className: 'empty_message'
  template: require './templates/user_empty'

class UserViewItem extends Marionette.ItemView

  className: 'user_item_view'
  template: require './templates/user_item'

module.exports = class UserView extends Marionette.CollectionView

  childView: UserViewItem
  emptyView: UserEmptyList