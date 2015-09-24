UserView = require './UserView'
UserCollection = Backbone.Model.extend({})
UserCollections = Backbone.Collection.extend({
  model: UserCollection
})
UserSearch = Backbone.Collection.extend({})

module.exports = class UserListView extends Marionette.LayoutView

  className: 'content_inner_block'
  template: require './templates/user_list'

  regions:
    list: '#list'

  events:
    'keyup #search' : 'showSearchUser'

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

    @user_collection.comparator = (UserCollection) ->
      -UserCollection.get('name')
    @user_collection.sort('name')
    console.log @user_collection

  onShow: ->
    @list.show new UserView collection: @user_collection

  showSearchUser: (e) ->
    console.log $(e.currentTarget).val()
    user_collection = new UserCollections()
    search = $(e.currentTarget).val()
    UsersData.forEach (data) ->
      if data.name.search(search) != - 1 || data.age.search(search) != - 1 || data.country.search(search) != - 1
        user_collection.push
          name:     data.name
          age:      data.age
          country:  data.country
          member:   data.member
          activity: data.activity
    @user_collection = user_collection
    @onShow()





