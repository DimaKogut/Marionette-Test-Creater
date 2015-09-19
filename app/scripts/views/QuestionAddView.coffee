class NewQuestion extends Marionette.ItemView

  className: 'new_test_question'
  template: require './templates/add_question'

  events:
    'click .test_remove_button' : 'remove_question'

  remove_question: ->
    @model.destroy()

module.exports = class QuestionAddView extends Marionette.CollectionView

  childView: NewQuestion
  emptyView: ''

