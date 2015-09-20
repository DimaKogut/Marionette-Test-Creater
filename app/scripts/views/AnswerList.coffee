class AnswerItem extends Marionette.ItemView

  template: require './templates/answerlist'

  events:
    'click .color'     : 'remove_answer'
    'change .answer' : 'change'

  remove_answer: ->
    @model.destroy()

  change: (e) ->
    value = $(e.currentTarget).val()
    @model.set 'answer_save', value

module.exports = class AnswerList extends Marionette.CollectionView

  childView: AnswerItem
  emptyView: ''
