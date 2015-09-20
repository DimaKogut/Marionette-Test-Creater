AnswerList = require './AnswerList'

AnswerCollection = Backbone.Collection.extend({})

class NewQuestion extends Marionette.LayoutView

  className: 'new_test_question'
  template: require './templates/add_question'

  initialize: ->
    @answer_modal = new AnswerCollection()
    @counter = @model.get 'number_of_answer'
    @listenTo @answer_modal, 'remove', ->
      @model.set 'number_of_answer', @answer_modal.length
      @count_number_of_answer()
      @onShow()
    @listenTo @answer_modal, 'change', (data) ->
      n = data.get 'answer_number'
      console.log n
      @model.set 'answer_save_' + n + '', data.get 'answer_save'
    n = 0
    while n < @counter
      l = n + 1
      save_answer = @model.get 'answer_save_' + l + ''
      p = if save_answer == undefined then '' else @model.get 'answer_save_' + l + ''
      @answer_modal.push
        answer_number: n + 1
        answer_save: p
      n++

  events:
    'click .add_answer'         : 'add_answer'
    'click .test_remove_button' : 'remove_question'
    'change #answer'            : 'save_question'

  regions:
    answer_region: '#answer_region'

  count_number_of_answer: ->
    n = 0
    while n < @answer_modal.models.length
      @answer_modal.models[n].set 'answer_number', n + 1
      n++
    @onShow()

  onShow: ->
    console.log @answer_modal
    @answer_region.show new AnswerList collection: @answer_modal
    if @answer_modal.models.length > 2 then @$('.glyphicon-remove').addClass 'color' else @$('.glyphicon-remove').removeClass 'color'

  add_answer: ->
    counter = @answer_modal.models.length
    @answer_modal.push
      answer_number: counter + 1
      answer_save: ''
    @model.set 'number_of_answer', @answer_modal.length
    @onShow()

  remove_question: ->
    @model.destroy()

  save_question: (e) ->
    value = $(e.currentTarget).val()
    @model.set 'question_save', value

module.exports = class QuestionAddView extends Marionette.CollectionView

  childView: NewQuestion
  emptyView: ''

