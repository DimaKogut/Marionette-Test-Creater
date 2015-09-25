class SubCategoryViewItem extends Marionette.ItemView

  initialize: ->
    console.log @model

  className: 'sub_category_item'
  template: require './templates/sub_category_item_view'

module.exports = class SubCategoryView extends Marionette.CollectionView

  initialize: ->

    console.log @collection

  childView: SubCategoryViewItem
  emptyView: ''