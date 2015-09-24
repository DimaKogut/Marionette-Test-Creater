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
    'keyup #search'       : 'showSearchUser'
    'click .numerical'    : 'sort_user_list_numerical'
    'click .no_numerical' : 'sort_user_list_no_numerical'

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

    # reverseSortBy = (sortByFunction) ->
    #   (left, right) ->
    #     console.log left, right
    #     l = sortByFunction(left)
    #     r = sortByFunction(right)
    #     if l == undefined
    #       return -1
    #     if r == undefined
    #       return 1
    #     if l < r then 1 else if l > r then -1 else 0

    # @user_collection.comparator = (UserCollection) ->
    #   UserCollection.get 'name'

    # @user_collection.comparator = reverseSortBy(@user_collection.comparator)

    # @user_collection.comparator = (UserCollection) ->
    #   +UserCollection.get('age')

    # @user_collection.sort('name')
    # console.log @user_collection

  onShow: ->
    @list.show new UserView collection: @user_collection

  showSearchUser: (e) ->
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

  sort_user_list_numerical: (e) ->
    filter = $(e.currentTarget).attr 'name'
    if $(e.currentTarget).hasClass 'descending'
      $('.descending').removeClass 'descending'
      $(e.currentTarget).addClass 'ascending'
      @user_collection.comparator = (UserCollection) ->
        -UserCollection.get filter
      @user_collection.sort filter
    else
      $('.ascending').removeClass 'ascending'
      $(e.currentTarget).addClass 'descending'
      @user_collection.comparator = filter
      @user_collection.sort filter

  sort_user_list_no_numerical: (e) ->
    filter = $(e.currentTarget).attr 'name'
    if $(e.currentTarget).hasClass 'descending'
      $('.descending').removeClass 'descending'
      $(e.currentTarget).addClass 'ascending'
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
      $('.ascending').removeClass 'ascending'
      $(e.currentTarget).addClass 'descending'
      @user_collection.comparator = filter
      @user_collection.sort filter
