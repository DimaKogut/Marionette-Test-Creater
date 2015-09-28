class SubCategoryViewItem extends Marionette.ItemView

  className: 'sub_category_item_left'
  template: require './templates/sub_category_item_view'

module.exports = class SubCategoryView extends Marionette.CollectionView

  childView: SubCategoryViewItem
  emptyView: ''

