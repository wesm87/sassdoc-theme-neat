class App
  LINK_CLASS = 'result-link'

  $items = $('article.item')
  $groupsHandler = $('ul.list h2.type-title')
  $searchInput = $('.search-field')
  $searchForm = $('[data-role=search-form]')
  $suggestionContainer = $('.suggestion-container')
  $suggestions = $(".#{@LINK_CLASS}")
  suggestions = []

  searchOptions =
    keys: ['name']
    threshold: 0.3
    caseSensitive: false

  items = @$items.map (index, element) ->
    $item = $(element)

    name: $item.data 'name'
    type: $item.data 'type'
    node: $item

  searchEngine = new Fuse @items, @searchOptions

  constructor: ->
    hljs.initHighlightingOnLoad()
    @initGroupsToggle()
    @initSearch()

  collapseGroup = (pointer) ->
    pointer
      .removeClass 'expanded'
      .css 'max-height', ''

  expandGroup = (pointer) ->
    pointerPosition = pointer.position().top
    ulMaxHeight   = parseInt(pointer.find('li').length) * 45 + 55;

    pointer
      .addClass 'shown'
      .css 'max-height', "#{ulMaxHeight}px"

    $('.side-nav').animate { scrollTop: pointerPosition }, 800

  initGroupsToggle: ->
    @$groupsHandler.on 'click', (event) =>
      $target = $(event.target)
      $group = $target.parent('ul')

      if $group.hasClass('expanded')
        @collapseGroup $group
      else
        @expandGroup $group

  fillSuggestions: (items) ->
    @$suggestionContainer.html ''

    @suggestions = $.map(items.slice(0, 10), (item) ->
      itemHTML = "
        <li>
          <a href='##{item.name}' class='result-link'>
            <code>#{item.type.slice(0, 1)}</code>
            #{item.name}
          </a>
        </li>
      "

      itemAtts =
        'data-type': item.type
        'data-name': item.name
        'class': 'result'

      $item = $(itemHTML, itemAtts)

      @$suggestionContainer.append $item
    )

  search: (term) ->
    @fillSuggestions(searchEngine.search(term))

  initSearch: ->
    @$searchInput
      .on 'keyup', (event) =>
        if event.keyCode is 40 or event.keyCode is 38
          event.preventDefault()
        else
          $input = $(event.currentTarget)
          currentSelection = -1
          @suggestions = @search $input.val()
        return
      .on 'search', (event) =>
        $input = $(event.currentTarget)
        @suggestions = @search $input.val()
        return

    @$suggestionContainer.on 'click', @LINK_CLASS, (event) =>
      $target = $(event.target)
      @$searchInput.val $target.parent().data 'name'
      @suggestions = @fillSuggestions([])

$ -> new App
