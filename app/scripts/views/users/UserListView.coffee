UserView = require './UserView'

UserCollections = Backbone.Collection.extend({})
UserSearch = Backbone.Collection.extend({})

module.exports = class UserListView extends Marionette.LayoutView

  className: 'content_inner_block'
  template: require './templates/user_list'

  events:
    'keyup #search' : 'showSearchUser'

  regions:
    list: '#list'

  # behaviors:
  #   SortAction: collection_name: 'user_collection'

  initialize: ->
    $('.navigator_active').removeClass 'navigator_active'
    $('#user_list').addClass 'navigator_active'
    user_collection = new UserCollections()
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

  showSearchUser: (e) ->
    user_collection = new UserCollections()
    search = $(e.currentTarget).val().toLowerCase()
    UsersData.forEach (data) ->
      if data.name.toLowerCase().search(search) != - 1 || data.age.search(search) != - 1 || data.country.toLowerCase().search(search) != - 1
        user_collection.push
          name:     data.name
          age:      data.age
          country:  data.country
          member:   data.member
          activity: data.activity
    @user_collection = user_collection
    @onShow()