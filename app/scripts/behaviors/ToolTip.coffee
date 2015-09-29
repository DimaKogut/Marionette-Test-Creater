module.exports = class ToolTip extends Marionette.Behavior

  onShow: ->
    @$(@options.className).tooltip title: @options.text
