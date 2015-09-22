class SubCategoryItem extends Marionette.ItemView

  tagName: 'li'
  className: 'sub_category_item'
  template: require './templates/subcategory_item_view'

module.exports = class SubCategoryView extends Marionette.CollectionView

  childView: SubCategoryItem
  emptyView: ''

  events:
    'click .sub_category_item' : 'choose_category'

  choose_category: (e) ->
    @$('.active').removeClass 'active'
    $(e.currentTarget).addClass 'active'


