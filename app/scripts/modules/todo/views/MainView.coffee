Todo = require('../models/Todo')
Todos = require('../collections/Todos')

module.exports = class MainView extends Backbone.Marionette.CompositeView
  template: require './templates/main'
  childViewContainer: '.question_add'
  childView: require('./TodoView')

  behaviors:
    Closeable: {}

  ui:
    text_button: '.test_create_form'

  events:
    "submit @ui.form": "addTodo"
    'click .test_create_form': 'resize'

  addTodo: (e) ->
    e.preventDefault()

    data = Backbone.Syphon.serialize(@)
    @collection.add(new Todo({ text: data.todo }))

    @render()
    # App.vent.trigger 'new:notification', "Added todo: " + data.todo

  onRender: ->
    # @ui.input.focus()

  resize: (e) ->
    $(e.currentTarget).addClass('resize')
    this.ui.text_button.html(' ')
    setTimeout (->
      $('.test_add_button').addClass 'active'
      return
    ), 700
