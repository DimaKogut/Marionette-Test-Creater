TestListCategoryView = require './TestListCategoryView'
MainTestCollection = require './MainTestCollection'
ActivityListView = require './ActivityListView'

MainCategoryCollection = Backbone.Collection.extend({})
ActivityCollection = Backbone.Collection.extend({})

module.exports = class TestListView extends Marionette.LayoutView

  className: 'main_test_list'
  template: require './templates/test_list'

  events:
    'click .load_more_activity' : 'show_all_activity'

  regions:
    main_category_region: '.inner_content'
    main_list_region:     '.inner_list_block'
    activity_region:      '.activity_inner_content'

  ui:
    load_more:          '.load_more_activity'
    load_more_activity: '.load_more_value'

  initialize: ->
    $('.navigator_active').removeClass 'navigator_active'
    $('#test_list').addClass 'navigator_active'

  onShow: ->
    main_category_list = new MainCategoryCollection()
    categoryData.Category.forEach (data) ->
      main_category_list.push
        category_name: data
    @main_category_list = main_category_list
    @main_category_region.show new TestListCategoryView collection: @main_category_list
    @main_list_region.show new MainTestCollection()
    @showActivity 9

  showActivity: (number) ->
    @activity_list = new ActivityCollection()
    n = 0
    while n < number
      @activity_list.push
        name:        ActivityData[n].name
        test_name:   ActivityData[n].test_name
        description: ActivityData[n].description
        result:      ActivityData[n].result
      n++
    @activity_region.show new ActivityListView collection: @activity_list
    if ActivityData.length > 9
      @ui.load_more.show()
      @ui.load_more_activity.html ActivityData.length - 9

  show_all_activity: ->
    @showActivity ActivityData.length
    @ui.load_more.hide()
