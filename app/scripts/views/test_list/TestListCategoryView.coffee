SubCategoryView = require './SubCategoryView'

SubCollections = Backbone.Collection.extend({})

class TestListCategoryItem extends Marionette.LayoutView

  className: 'inner'
  template: require './templates/test_list_category_item'

  events:
    'click .show_subcat' : 'show_subcat'
    'click .cat_name_title' : 'show_cat_list'

  regions:
    inner_sub_cat: '.subcat_area'

  show_cat_list: (e) ->
    n = @model.get 'category_name'
    App.vent.trigger 'chack:cat', n
    $('.active_cat_button').removeClass 'active_cat_button'
    @$('.show_subcat').parent().addClass 'active_cat_button'

  show_subcat: (e) ->
    @$('.subcat_area').toggle()
    n = @model.get 'category_name'
    sub_category = subcategoryData["" + n + ""]
    subcategory = new SubCollections()
    if sub_category != undefined
      sub_category.forEach (data) ->
        subcategory.push
          subcategory_name: data
      @subcategory = subcategory
    @inner_sub_cat.show new SubCategoryView collection: @subcategory

module.exports = class TestListCategoryView extends Marionette.CollectionView

  className: 'test_categoty_conteinar'
  childView: TestListCategoryItem
  emptyView: ''