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
    if !$(e.target).hasClass 'show_subcat'
      if !$(e.target).hasClass 'active_cat_button'
        n = @model.get 'category_name'
        App.vent.trigger 'chack:cat', n
        $('.active_cat_button').removeClass 'active_cat_button'
        @$('.cat_name_title').addClass 'active_cat_button'
      else
        App.vent.trigger 'chack:cat', 'all'
        @$('.active_cat_button').removeClass 'active_cat_button'
    else
      if @$('.subcat_area').is ':hidden'
        $('glyphicon-chevron-up').removeClass 'glyphicon-chevron-up'
        $('.show_subcat').addClass 'glyphicon-chevron-down'
        $('.subcat_area:visible').slideUp()
        @$('.glyphicon-chevron-down').removeClass 'glyphicon-chevron-down'
        @$(e.target).addClass 'glyphicon-chevron-up'
      else
        @$('.glyphicon-chevron-up').removeClass 'glyphicon-chevron-up'
        @$(e.target).addClass 'glyphicon-chevron-down'
      @$('.subcat_area').slideToggle()

  show_subcat: (e) ->
    n = @model.get 'category_name'
    sub_category = subcategoryData["" + n + ""]
    subcategory = new SubCollections()
    if sub_category != undefined
      sub_category.forEach (data) ->
        n = 0
        number = 0
        while n < TestData.length
          if TestData[n].subcategory == data
            number += 1
          n++
        subcategory.push
          subcategory_name: data
          number_of_test:   number
      @subcategory = subcategory
    console.log @subcategory
    @inner_sub_cat.show new SubCategoryView collection: @subcategory

module.exports = class TestListCategoryView extends Marionette.CollectionView

  className: 'test_categoty_conteinar'
  childView: TestListCategoryItem
  emptyView: ''