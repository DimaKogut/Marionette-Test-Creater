AllTestListView = require './AllTestListView'

CurrentCollection = Backbone.Collection.extend({})

module.exports = class MainTestCollection extends Marionette.LayoutView

  template: require './templates/main_test_containar'

  events:
    'keyup .test_search'  : 'showSearchUser'

  regions:
    main_test_top:  '.main_test_top'
    middle_content: '.middle_content'

  behaviors:
    SortAction: collection_name: 'currentCollection', model_name: 'TestListCollection'

  ui:
    test_name_choose: '.test_name_choose'
    test_description: '.test_description'

  initialize: ->
    @listenTo App.vent.on 'chack:cat', @render_category_list, @
    @listenTo App.vent.on 'click:subcat_slide_menu', @render_category_list_by_subcat, @
    @listenTo App.vent.on 'choose:test', @choose_current_test, @
    @showAll()

  onShow: ->
    @middle_content.show new AllTestListView collection: @currentCollection

  showAll: ->
    currentCollection = new CurrentCollection()
    TestData.forEach (data) ->
      currentCollection.push
        test_name:   data.test_name
        subcategory: data.subcategory
        description: data.description
    @currentCollection = currentCollection

  showSearchUser: (e) ->
    currentCollection = new CurrentCollection()
    search = $(e.currentTarget).val().toLowerCase()
    if @value != undefined
      @value.models.forEach (data) ->
        if data.get('test_name').toLowerCase().search(search) != - 1 || data.get('subcategory').toLowerCase().search(search) != - 1
          currentCollection.push
            test_name:   data.get('test_name')
            subcategory: data.get('subcategory')
            description: data.get('description')
    else
      TestData.forEach (data) ->
        if data.test_name.toLowerCase().search(search) != - 1 || data.subcategory.toLowerCase().search(search) != - 1
          currentCollection.push
            test_name:   data.test_name
            subcategory: data.subcategory
            description: data.description
    @currentCollection = currentCollection
    @onShow()

  render_category_list: (data) ->
    if data == 'all'
      @onShow @showAll()
    else
      category_name = data
      value = new CurrentCollection()
      TestData.forEach (name) ->
        if name.category == category_name
          value.push name
      @value = value
      @middle_content.show new AllTestListView collection: @value

  render_category_list_by_subcat: (data) ->
    value = new CurrentCollection()
    TestData.forEach (name) ->
      if name.subcategory == data.get 'subcategory_name'
        value.push name
    @value = value
    @middle_content.show new AllTestListView collection: @value

  choose_current_test: (data) ->
    @ui.test_name_choose.html data.get 'test_name'
    @ui.test_description.html data.get 'description'
    if $('.main_test_top').is ':hidden'
      $('.main_test_top').slideToggle()
