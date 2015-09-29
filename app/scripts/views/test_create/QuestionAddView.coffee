AnswerList = require './AnswerList'

AnswerCollection = Backbone.Collection.extend({})

class NewQuestion extends Marionette.LayoutView

  className: 'new_test_question'
  template: require './templates/add_question'

  events:
    'click .add_answer'         : 'add_answer'
    'click .test_remove_button' : 'remove_question'
    'change #answer'            : 'save_question'

  regions:
    answer_region: '#answer_region'

  initialize: ->
    @model = @model
    @answer_modal = new AnswerCollection()
    @counter = @model.get 'number_of_answer'
    @listenTo @answer_modal, 'remove', ->
      @model.set 'number_of_answer', @answer_modal.length
      @count_number_of_answer()
      @onShow()
    @listenTo @answer_modal, 'change:answer_save', (data) ->
      n = data.get 'answer_number'
      @model.set 'answer_save_' + n + '', data.get 'answer_save'
    @listenTo @answer_modal, 'change:correct', (data) ->
      i = data.get 'correct'
      k = data.get 'answer_number'
      o = if i == true then k else ''
      @model.set 'correct_answer', o
      @recheck_correct_answer()

    n = 0
    correct = @model.get 'correct_answer'
    @correct = if correct != '' then correct else false
    while n < @counter
      l = n + 1
      save_answer = @model.get 'answer_save_' + l + ''
      p = if save_answer == undefined then '' else @model.get 'answer_save_' + l + ''
      @answer_modal.push
        answer_number: n + 1
        answer_save: p
        correct_answer: @correct
        correct: false
      n++

  count_number_of_answer: ->
    n = 0
    while n < @answer_modal.models.length
      @answer_modal.models[n].set 'answer_number', n + 1
      n++
    @onShow()

  recheck_correct_answer: ->
    correct = @model.get 'correct_answer'
    correct = if correct != '' then correct else false
    n = 0
    while n < @answer_modal.models.length
      @answer_modal.models[n].set 'correct_answer', correct
      n++
    @onShow()

  onShow: ->
    @AnswerList = new AnswerList collection: @answer_modal
    @answer_region.show @AnswerList
    if @answer_modal.models.length > 2 then @$('.glyphicon-remove').addClass 'color' else @$('.glyphicon-remove').removeClass 'color'

  add_answer: ->
    counter = @answer_modal.models.length
    @answer_modal.push
      answer_number: counter + 1
      answer_save: ''
      correct_answer: false
    @model.set 'number_of_answer', @answer_modal.length
    correct = @model.get 'correct_answer'
    @correct = if correct != '' then correct else false
    if @correct != false then @recheck_correct_answer() else @onShow()

  remove_question: ->
    @model.destroy()

  save_question: (e) ->
    value = $(e.currentTarget).val()
    @model.set 'question_save', value

module.exports = class QuestionAddView extends Marionette.CollectionView

  childView: NewQuestion
  emptyView: ''