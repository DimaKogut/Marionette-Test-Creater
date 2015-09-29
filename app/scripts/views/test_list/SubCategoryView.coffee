class SubCategoryViewItem extends Marionette.ItemView

  className: 'sub_category_item_left'
  template: require './templates/sub_category_item_view'

  events:
    'click': -> @subcat_specify()

  subcat_specify: ->
    $('.add_number_of_test').removeClass 'add_number_of_test'
    $(@el).addClass 'add_number_of_test'
    $('.active_cat_button').removeClass 'active_cat_button'
    App.vent.trigger 'click:subcat_slide_menu', @model

module.exports = class SubCategoryView extends Marionette.CollectionView

  childView: SubCategoryViewItem
  emptyView: ''

