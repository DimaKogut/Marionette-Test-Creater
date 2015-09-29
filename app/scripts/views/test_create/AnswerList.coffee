class AnswerItem extends Marionette.ItemView

  template: require './templates/answerlist'

  events:
    'click .color'   : 'remove_answer'
    'change .answer' : 'change'
    'click .correct' : 'specify_answer'

  ui:
    correct_answer: '.correct'

  templateHelpers: ->
    answer_number_concat: (data, number) ->
      data = if data.split(' ').length == 2 then data.split(' ')[1] else data
      if data != '' then '' + number + '. ' + data + '' else ''

    correct_answer_specify: (number, correct_answer) ->
      if correct_answer != false then if number == correct_answer then 'color_correct' else ''

  remove_answer: ->
    n = @model.get 'correct_answer'
    b = @model.get 'answer_number'
    if n == b then @model.set 'correct', false
    @model.destroy()

  change: (e) ->
    value = $(e.currentTarget).val()
    @model.set 'answer_save', value
    @render()

  specify_answer: (e) ->
    @$('.color_correct').removeClass 'color_correct'
    $(e.currentTarget).addClass 'color_correct'
    @model.set 'correct', true

module.exports = class AnswerList extends Marionette.CollectionView

  childView: AnswerItem
  emptyView: ''