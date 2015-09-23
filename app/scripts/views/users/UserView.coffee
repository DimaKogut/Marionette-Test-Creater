UserTestList = require './UserTestList'

TestListCollection = Backbone.Collection.extend({})

class UserEmptyList extends Marionette.ItemView

  className: 'empty_message'
  template: require './templates/user_empty'

class UserViewItem extends Marionette.LayoutView

  template: require './templates/user_item'

  events:
    'click .u_list_block': 'slide_user'

  regions:
    test_list_region: '.test_list_region'

  slide_user: ->
    n = if @$('.user_test_data').is(':hidden') then 241 else 41
    @$('.user_item_view').animate {'height': '' + n + 'px'}, 500
    @$('.user_test_data').slideToggle(500)
    @show_modular(@model.get 'name')
    @show_test_list_result()
    $('.showed').removeClass 'showed'
    @$('.u_list_block').addClass 'showed'
    console.log UsersTestResult['John Smith']

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
        value: red
        color: '#cd5c5c'
        highlight: '#FF5A5E'
        label: 'Not good'
      }
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
    ]
    pie_ctx = document.getElementById('pie-chart-area').getContext('2d')
    window.myPie = new Chart(pie_ctx).Pie(pieData, legendTemplate: '<ul class="<%=name.toLowerCase()%>-legend"><% for (var i=0; i<segments.length; i++){%><li><span style="background-color:<%=segments[i].fillColor%>"></span><%if(segments[i].label){%><%=segments[i].label%><%}%></li><%}%></ul>')
    legend = myPie.generateLegend()
    $("#legend").html legend

  show_test_list_result: ->
    test_list = new TestListCollection()
    UsersTestResult[1].forEach (data) ->
      test_list.push
        test_name:   data.test_name
        data_passed: data.data_passed
        result:      data.result
    @test_list = test_list
    @test_list_region.show new UserTestList collection: @test_list

module.exports = class UserView extends Marionette.CollectionView

  childView: UserViewItem
  emptyView: UserEmptyList

