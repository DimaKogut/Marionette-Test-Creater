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

  initialize: ->
    @category = new CategoryCollections()
    n = 0
    while n < categoryData.Category.length
      @category.push
        category_name: categoryData.Category[n]
      n++
    @listenTo App.vent.on 'choose:subcategory', @onshowreg, @

  onShow: ->
    @category_region.show new CategoryView collection: @category

  onshowreg: (data) ->
    n = data.get 'category_name'
    length = subcategoryData["" + n + ""]
    @subcategory = new SubCategoryCollections()
    n = 0
    while n < length.length
      @subcategory.push
        subcategory_name: length[n]
      n++
    @subcategory_region.show new SubCategoryView collection: @subcategory





