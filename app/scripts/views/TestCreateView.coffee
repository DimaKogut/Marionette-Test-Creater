QuestionAddView = require './QuestionAddView'

TestQuestions = Backbone.Collection.extend({})

module.exports = class TestCreateView extends Marionette.LayoutView

  template: require './templates/test_create'

  initialize: ->

    @question_list = new TestQuestions()
    @listenTo @question_list, 'remove', ->
      @question_counter()
      @add_button()
    @listenTo @question_list, 'add', ->
      @add_button()

  ui:
    text_button: '.test_create_form'

  events:
    'click .test_create_form' : 'resize'
    'click .test_add_button'  : 'add_question'

  # triggers:
  #   'click .test_create_form': 'resizes'

  regions:
    question: '.question_add'

  resize: (e) ->

    App.vent.trigger 'new:click', 'it"s clicked'

    $(e.currentTarget).addClass('resize')
    this.ui.text_button.html(' ')
    @add_button()

  add_button: ->
    setTimeout (->
      $('.test_add_button:last').addClass 'active'
      return
    ), 500

  add_question: ->
    @question_list.push
      question_number: 0
      answer: 'Your answer'
      correct_answer: 'Your correct answer'
      number_of_answer: 2
      question_save: ''
    @question_counter()

  question_counter: ->
    counter = 1
    @question_list.models.forEach (data) ->
      data.set 'question_number', counter
      counter++
    if @question_list.models.length != 0 then $('.active').removeClass 'active' else @add_button()
    @question.show new QuestionAddView collection: @question_list
    $('html, body').animate { scrollTop: $(document).height() }, 'slow'