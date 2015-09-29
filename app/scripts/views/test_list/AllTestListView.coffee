class CurrentCategoryList extends Marionette.ItemView

  className: 'all_test_item'
  template: require './templates/all_test_item'

  events:
    'click .containar_test_list' : -> App.vent.trigger 'choose:test', @model

class CurrentCategoryListEmpty extends Marionette.ItemView

  className: 'empty_current_list'
  template: require './templates/empty_current_list'

module.exports = class AllTestListView extends Marionette.CollectionView

  childView: CurrentCategoryList
  emptyView: CurrentCategoryListEmpty