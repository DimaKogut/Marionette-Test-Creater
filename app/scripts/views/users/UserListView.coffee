UserView = require './UserView'

UserCollection = Backbone.Model.extend({})
UserCollections = Backbone.Collection.extend({
  model: UserCollection
})
UserSearch = Backbone.Collection.extend({})

module.exports = class UserListView extends Marionette.LayoutView

  className: 'content_inner_block'
  template: require './templates/user_list'

  events:
    'keyup #search'       : 'showSearchUser'
    'click .numerical'    : 'sort_user_list_numerical'
    'click .no_numerical' : 'sort_user_list_no_numerical'

  regions:
    list: '#list'

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

  sort_user_list_numerical: (e) ->
    filter = $(e.currentTarget).attr 'name'
    if $(e.currentTarget).hasClass 'descending'
      @sort_icon_dropdown e.currentTarget
      @user_collection.comparator = (UserCollection) ->
        -UserCollection.get filter
      @user_collection.sort filter
    else
      @sort_icon_dropup e.currentTarget
      @user_collection.comparator = (UserCollection) ->
        +UserCollection.get filter
      @user_collection.sort filter

  sort_user_list_no_numerical: (e) ->
    filter = $(e.currentTarget).attr 'name'
    if $(e.currentTarget).hasClass 'descending'
      @sort_icon_dropdown e.currentTarget
      reverseSortBy = (sortByFunction) ->
        (left, right) ->
          l = sortByFunction(left)
          r = sortByFunction(right)
          if l == undefined
            return -1
          if r == undefined
            return 1
          if l < r then 1 else if l > r then -1 else 0

      @user_collection.comparator = (UserCollection) ->
        UserCollection.get filter
      @user_collection.comparator = reverseSortBy(@user_collection.comparator)
      @user_collection.sort filter
    else
      @sort_icon_dropup e.currentTarget
      @user_collection.comparator = filter
      @user_collection.sort filter

  sort_icon_dropdown: (selector) ->
    $(selector).parent().removeClass 'dropup'
    $('.descending').removeClass 'descending'
    $(selector).addClass 'ascending'

  sort_icon_dropup: (selector) ->
    $(selector).parent().addClass 'dropup'
    $('.ascending').removeClass 'ascending'
    $(selector).addClass 'descending'
