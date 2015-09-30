QuestionListShow = require './QuestionListShow'

CurrentTestCollection = Backbone.Collection.extend({})

module.exports = class TestStartView extends Marionette.LayoutView

  template: require './templates/test_start'

  regions:
    questions_content_region: '.questions_content_region'

  templateHelpers: ->
    test_name:        @test_name
    test_category:    @test_category
    test_subcategory: @test_subcategory
    test_description: @test_description

  initialize: (options) ->
    @current_test = options.viewType
    @test_name        = options.data.get 'test_name'
    @test_category    = options.data.get 'category'
    @test_subcategory = options.data.get 'subcategory'
    @test_description = options.data.get 'description'

  onShow: ->
    questionCollection = new CurrentTestCollection()
    n = 1
    TestQuestionData[@current_test].forEach (data) ->
      questionCollection.push
        question_name: data
        number: n
      n++
    @questionCollection = questionCollection
    @questions_content_region.show new QuestionListShow collection: @questionCollection, current_test: @current_test