class CategoryItem extends Marionette.ItemView

  tagName: 'li'
  className: 'category_item'
  template: require './templates/category_item_view'

  events:
    'click .inner' : 'sub_list_show'

  sub_list_show: ->
    App.vent.trigger 'choose:subcategory', @model

module.exports = class CategoryView extends Marionette.CollectionView

  className: 'category_conteinar'

  childView: CategoryItem
  emptyView: ''

  events:
    'click .category_item' : 'choose_category'

  choose_category: (e) ->
    @$('.active').removeClass 'active'
    $(e.currentTarget).addClass 'active'


