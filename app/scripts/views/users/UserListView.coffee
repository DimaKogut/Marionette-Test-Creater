UserView = require './UserView'

UserCollection = Backbone.Collection.extend({})

module.exports = class UserListView extends Marionette.LayoutView

  className: 'content_inner_block'
  template: require './templates/user_list'

  regions:
    list: '#list'

  initialize: ->
    $('.navigator_active').removeClass 'navigator_active'
    $('#user_list').addClass 'navigator_active'
    user_collection = new UserCollection()
    UsersData.forEach (data) ->
      user_collection.push
        name:     data.name
        age:      data.age
        country:  data.country
        member:   data.member
        activity: data.activity
    @user_collection = user_collection

  onShow: ->
    @list.show new UserView collection: @user_collection


