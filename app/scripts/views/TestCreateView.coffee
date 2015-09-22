TestAttribute = require './NewTestAttribute'
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
    'click .add' : 'resize'
    'click .test_add_button'  : 'add_question'
    'keypress .cat' : 'add_category'

  regions:
    question:      '.question_add'
    new_test_main: '.test_create_form'

  resize: (e) ->
    $(e.currentTarget).addClass('resize')
    this.ui.text_button.html(' ')
    $('.add').removeClass('add')
    @TestAttribute = new TestAttribute()
    @new_test_main.show @TestAttribute
    $(e.currentTarget).bind 'transitionend webkitTransitionEnd oTransitionEnd MSTransitionEnd', ->
      $('.test_attribute').show()
    @add_button()

  add_category: (e) ->
    if e.keyCode == 13
      input = $(e.currentTarget)
      trigger_name = $(input).attr 'id'
      if input.val() != '' then App.vent.trigger 'add:' + trigger_name + '', input.val()
      input.val('')

  add_button: ->
    setTimeout (->
      $('.test_add_button:last').addClass 'active'
      return
    ), 500

  add_question: ->
    @question_list.push
      question_number: 0
      answer: 'Your answer'
      correct_answer: ''
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