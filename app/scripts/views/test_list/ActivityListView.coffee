class ActivityListItem extends Marionette.ItemView

  className: 'activity_single_item'
  template: require './templates/activity_list_item'

  events:
    'click .test_activity_name' : -> App.vent.trigger 'choose:test', @model

  behaviors:
    ToolTip: text: 'click to see more details', className: '.test_activity_name'

  templateHelpers: ->
    cut_test_name: (name) ->
      name = if name.length > 17 then name.substring(0, 17) + '...' else name

    result_color: (result) ->
      return if result > 69 then 'color_green' else if result > 49 then 'color_yellow' else 'color_red'

module.exports = class ActivityListView extends Marionette.CollectionView

  childView: ActivityListItem
  emptyView: ''