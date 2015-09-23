class EmptySubCategotyList extends Marionette.ItemView

  className: 'sub_category_empty'
  template: require './templates/subcategory_empty'

class SubCategoryItem extends Marionette.ItemView

  tagName: 'li'
  className: 'sub_category_item'
  template: require './templates/subcategory_item_view'

  events:
    'click .inner_sub' : 'sub_category_choose'

  sub_category_choose: ->
    App.vent.trigger 'choose:subcategory', @model.get 'subcategory_name'

module.exports = class SubCategoryView extends Marionette.CollectionView

  childView: SubCategoryItem
  emptyView: EmptySubCategotyList

  events:
    'click .sub_category_item' : 'choose_category'

  initialize: ->
    $('#sub').attr 'disabled', false
    $('#sub').focus()

  choose_category: (e) ->
    @$('.choose').removeClass 'choose'
    $(e.currentTarget).addClass 'choose'