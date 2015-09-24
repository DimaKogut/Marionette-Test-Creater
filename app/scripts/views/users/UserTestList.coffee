class UserTestListItem extends Marionette.ItemView

  className: 'user_test_list_item'
  template: require './templates/user_test_list'

  templateHelpers: ->
    procent_color: (result) ->
      return if result > 69 then 'color_green' else if result > 49 then 'color_yellow' else 'color_red'

module.exports = class UserTestList extends Marionette.CompositeView

  className: 'user_test_list_table'
  template: require './templates/user_test_list_conteinar'

  childView: UserTestListItem
  childViewContainer: '.test_list_conteinar'
  emptyView: ''
