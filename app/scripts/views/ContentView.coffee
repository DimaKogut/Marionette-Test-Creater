module.exports = class ContentView extends Marionette.ItemView

  template: require './templates/test_create'

  initialize: ->

  ui:
    text_button: '.test_create_form'

  events:
    'click .test_create_form': 'resize'

  # triggers:
  #   'click .test_create_form': 'resizes'

  resize: (e) ->

    App.vent.trigger 'new:click', 'it"s clicked'

    $(e.currentTarget).addClass('resize')
    this.ui.text_button.html(' ')
    setTimeout (->
      $('.test_add_button').addClass 'active'
      return
    ), 700

