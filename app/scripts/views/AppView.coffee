module.exports = class AppView extends Marionette.LayoutView
  template: require './templates/app'
  el: "#app"

  regions:
    content: '#content'


