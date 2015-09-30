UserTestList = require './UserTestList'

TestListCollections = Backbone.Collection.extend({})

class UserEmptyList extends Marionette.ItemView

  className: 'empty_message'
  template: require './templates/user_empty'

class UserViewItem extends Marionette.LayoutView

  template: require './templates/user_item'

  events:
    'click .u_list_block'      : 'slide_user'
    'click .load_more'         : 'load_more'

  regions:
    test_list_region: '.test_list_region'

  # behaviors:
  #   SortAction: collection_name: 'test_list'

  slide_user: (e)->
    m = $(e.currentTarget).parent().children()[1]
    if $(m).is(':hidden') == true
      if $('.user_test_data:visible').length == 1
        $('.user_test_data:visible').slideToggle(500)
        $('.user_test_data:visible').parent().animate {'height': '41px'}, 500
    n = if @$('.user_test_data').is(':hidden') then 251 else 41
    @$('.user_item_view').animate {'height': '' + n + 'px'}, 500
    @$('.user_test_data').css('height', '210px')
    @$('.user_test_data').slideToggle(500)
    @current_user = @model.get 'name'
    $('.showed').removeClass 'showed'
    if n == 251
      @show_modular(@model.get 'name')
      @show_test_list_result(@current_user, 6)
      @$('.u_list_block').addClass 'showed'

  show_modular: (options)->
    green = 0
    yellow = 0
    red = 0
    UsersTestResult['' + options + ''].forEach (data) ->
      if data.result > 69
        green += 1
      else
        if data.result > 49
          yellow += 1
        else
          red += 1

    pieData = [
      {
        value: green
        color: 'rgba(54,195,73,0.6)'
        highlight: 'rgba(117,255,136,0.52)'
        label: 'Excellent'
      }
      {
        value: yellow
        color: '#FFC870'
        highlight: '#f0e68c'
        label: 'Good'
      }
      {
        value: red
        color: '#cd5c5c'
        highlight: '#FF5A5E'
        label: 'Not good'
      }
    ]
    pie_ctx = document.getElementById('' + @model.get 'name' + '').getContext('2d')
    window.myPie = new Chart(pie_ctx).Pie(pieData)

  show_test_list_result: (user_name, length) ->
    test_list = new TestListCollections()
    n = 0
    if length == 6
      length = if UsersTestResult["" + user_name + ""].length < 6 then UsersTestResult["" + user_name + ""].length else 6
    else length = length
    while n < length
      test_list.push
        test_name:   UsersTestResult["" + user_name + ""][n].test_name
        data_passed: UsersTestResult["" + user_name + ""][n].data_passed
        result:      UsersTestResult["" + user_name + ""][n].result
      n++
    @test_list = test_list
    @test_list_region.show new UserTestList collection: @test_list
    m = UsersTestResult["" + user_name + ""].length - 6
    if m > 0
      @$('.load_more').show()
      @$('.load_more_value').html m

  load_more: (data)->
    number = UsersTestResult['' +  @model.get 'name' + ''].length
    @show_test_list_result(@current_user, number)
    number -= 6
    height_main_block = 251 + number * 23
    height_inner_block = 210 + number * 23
    @$('.user_item_view').animate {'height': '' + height_main_block + 'px'}, 200
    @$('.user_test_data').animate {'height': '' + height_inner_block + 'px'}, 200
    $('.load_more').hide()

module.exports = class UserView extends Marionette.CollectionView

  childView: UserViewItem
  emptyView: UserEmptyList
