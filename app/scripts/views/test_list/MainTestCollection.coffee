AllTestListView = require './AllTestListView'

CurrentCollection = Backbone.Collection.extend({})

module.exports = class MainTestCollection extends Marionette.LayoutView

  template: require './templates/main_test_containar'

  regions:
    main_test_top:  '.main_test_top'
    middle_content: '.middle_content'

  ui:
    test_name_choose: '.test_name_choose'
    test_description: '.test_description'

  initialize: ->
    @listenTo App.vent.on 'chack:cat', @render_category_list, @
    @listenTo App.vent.on 'choose:test', @choose_current_test, @

  onShow: ->
    currentCollection = new CurrentCollection()
    TestData.forEach (data) ->
      currentCollection.push
        test_name:   data.test_name
        subcategory: data.subcategory
        description: data.description
    @currentCollection = currentCollection
    @middle_content.show new AllTestListView collection: @currentCollection
    # @rendom_test_offer()

  render_category_list: (data) ->
    category_name = data
    value = new CurrentCollection()
    TestData.forEach (name) ->
      if name.category == category_name
        value.push name
    @value = value
    @middle_content.show new AllTestListView collection: @value

  choose_current_test: (data) ->
    @ui.test_name_choose.html data.get 'test_name'
    @ui.test_description.html data.get 'description'
    if $('.main_test_top').is ':hidden'
      $('.main_test_top').slideToggle()
