TestListCategoryView = require './TestListCategoryView'

MainCategoryCollection = Backbone.Collection.extend({})

module.exports = class TestListView extends Marionette.LayoutView

  className: 'main_test_list'
  template: require './templates/test_list'

  regions:
    main_category_region:  '.inner_content'
    main_list_region: '.inner_list_block'
    activity_region:  '.activity_region'

  initialize: ->
    $('.navigator_active').removeClass 'navigator_active'
    $('#test_list').addClass 'navigator_active'
    @listenTo App.vent.on 'main_category:show_subcat', @show_subcat, @

  onShow: ->
    main_category_list = new MainCategoryCollection()
    categoryData.Category.forEach (data) ->
      main_category_list.push
        category_name: data
    @main_category_list = main_category_list
    @main_category_region.show new TestListCategoryView collection: @main_category_list

