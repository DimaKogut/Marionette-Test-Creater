module.exports = class SortAction extends Marionette.Behavior

  events:
    'click .no_numerical' : 'sort_collection_no_numarical'
    'click .numerical'    : 'sort_collection_numarical'

  sort_collection_no_numarical: (e) ->
    collection = @options.collection_name
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

      @view['' + collection + ''].comparator = (TestListCollection) ->
        TestListCollection.get filter
      @view['' + collection + ''].comparator = reverseSortBy(@view['' + collection + ''].comparator)
      @view['' + collection + ''].sort filter
    else
      @sort_icon_dropup e.currentTarget
      @view['' + collection + ''].comparator = filter
      @view['' + collection + ''].sort filter

  sort_collection_numarical: (e) ->
    collection = @options.collection_name
    filter = $(e.currentTarget).attr 'name'
    if $(e.currentTarget).hasClass 'descending'
      @sort_icon_dropdown e.currentTarget
      @view['' + collection + ''].comparator = (UserCollection) ->
        -UserCollection.get filter
      @view['' + collection + ''].sort filter
    else
      @sort_icon_dropup e.currentTarget
      @view['' + collection + ''].comparator = (UserCollection) ->
        +UserCollection.get filter
      @view['' + collection + ''].sort filter

  sort_icon_dropdown: (selector) ->
    $(selector).parent().removeClass 'dropup'
    $('.descending').removeClass 'descending'
    $(selector).addClass 'ascending'

  sort_icon_dropup: (selector) ->
    $(selector).parent().addClass 'dropup'
    $('.ascending').removeClass 'ascending'
    $(selector).addClass 'descending'