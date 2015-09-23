CategoryView = require './CategoryView'
SubCategoryView = require './SubCategoryView'

CategoryCollections = Backbone.Collection.extend({})
SubCategoryCollections = Backbone.Collection.extend({})

module.exports = class TestAttribute extends Marionette.LayoutView

  className: 'test_attribute'
  template: require './templates/test_attribute'

  regions:
    category_region:    '.left_cat_region'
    subcategory_region: '.right_sub_region'

  events:
    'click .description' : 'category_add'

  ui:
    category_specify: '.parent_specify'
    subcategory_specify: '.child_specify'

  initialize: ->
    @category = new CategoryCollections()
    n = 0
    while n < categoryData.Category.length
      @category.push
        category_name: categoryData.Category[n]
      n++
    @listenTo App.vent.on 'choose:category', @onshow_subcategory, @
    @listenTo App.vent.on 'choose:subcategory', @subcategory_choose, @
    @listenTo App.vent.on 'add:cat', @add_new_category, @
    @listenTo App.vent.on 'add:sub', @add_new_subcategory, @

  onShow: ->
    @category_region.show new CategoryView collection: @category

  add_new_category: (data)->
    @category.unshift
      category_name: data
    @onShow()

  add_new_subcategory: (data) ->
    console.log @subcategory
    @subcategory.unshift
      subcategory_name: data
    @subcategory_region.show new SubCategoryView collection: @subcategory

  onshow_subcategory: (data) ->
    n = data.get 'category_name'
    @ui.category_specify.html n
    if @ui.subcategory_specify.html != '' then @ui.subcategory_specify.html ''
    sub_category = subcategoryData["" + n + ""]
    @subcategory = new SubCategoryCollections()
    if sub_category != undefined
      n = 0
      while n < sub_category.length
        @subcategory.push
          subcategory_name: sub_category[n]
        n++
    @view = new SubCategoryView collection: @subcategory
    @subcategory_region.show @view
    @view.on 'choose_category', ->
      SubCategoryView.choose_category()

  subcategory_choose: (data) ->
    @ui.subcategory_specify.html data
