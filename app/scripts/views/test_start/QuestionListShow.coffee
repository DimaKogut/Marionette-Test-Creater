# class AnswerList extends Marionette.CollectionView

#   childView: AnswerListItem
#   emptyView: ''

AnswerListCollection = Backbone.Collection.extend({})

class QuestionListItem extends Marionette.LayoutView

  className: 'question_name_item'
  template: require './templates/question_area'

  regions:
    answer_area: '.answer_area'

  initialize: (options) ->
    number = options.current_test
    answer_collection = new AnswerListCollection()
    TestAnswerData[number][@model.get 'number'].forEach (data) ->
      answer_collection.push
        answer: data

  onShow: ->
    # @answer_area.show new

module.exports = class QuestionListShow extends Marionette.CollectionView

  childView: QuestionListItem
  emptyView: ''

  initialize: (options) ->
    @test_name = options.current_test

  buildChildView: (options) ->
    view = new QuestionListItem model: options, current_test: @test_name

