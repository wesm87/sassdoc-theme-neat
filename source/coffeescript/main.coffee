class App
  LINK_CLASS: 'result-link'

  $items: null
  $groupsHandler: null
  $searchInput: null
  $searchForm: null
  $suggestionsContainer: null
  $suggestions: null

  items: []
  suggestions: []
  searchEngine: null
  searchOptions:
    keys: ['name']
    threshold: 0.3
    caseSensitive: false


  constructor: ->
    hljs.initHighlightingOnLoad()

    @$items = $('article.item')
    @$groupsHandler = $('.js-list-group-toggle')
    @$searchInput = $('#js-search-field')
    @$searchForm = $('#js-search-form')
    @$suggestionsContainer = $('#js-suggestions-container')
    @$suggestions = @$suggestionsContainer.find @LINK_CLASS

    @items = @$items.map (index, element) =>
      $item = $(element)

      name: $item.data 'name'
      type: $item.data 'type'
      node: $item

    @searchEngine = new Fuse @items, @searchOptions

    @initGroupsToggle()
    @initSearch()

  collapseGroup: (pointer) =>
    pointer
      .removeClass 'expanded'
      .css 'max-height', ''

  expandGroup: (pointer) =>
    pointerPosition = pointer.position().top

    pointer.css 'max-height', 'none'
    pointer
      .addClass 'expanded'
      .css 'max-height', "#{pointer.outerHeight()}px"

    $('.side-nav').animate { scrollTop: pointerPosition }, 800

  initGroupsToggle: =>
    @$groupsHandler.on 'click', (event) =>
      $target = $(event.target)
      $group = $target.parent('.js-list-group')

      if $group.hasClass('expanded')
        @collapseGroup $group
      else
        @expandGroup $group
    return

  fillSuggestions: (items) =>
    @$suggestionsContainer.html ''

    @suggestions = $.map items.slice(0, 10), (item) =>
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

      @$suggestionsContainer.append $item

  search: (term) =>
    @fillSuggestions(@searchEngine.search(term))

  initSearch: =>
    @$searchInput
      .on 'keyup', (event) =>
        if event.keyCode is 40 or event.keyCode is 38
          event.preventDefault()
        else
          $input = $(event.currentTarget)
          @suggestions = @search $input.val()
        return
      .on 'search', (event) =>
        $input = $(event.currentTarget)
        @suggestions = @search $input.val()
        return

    @$suggestionsContainer.on 'click', @LINK_CLASS, (event) =>
      $target = $(event.target)
      @$searchInput.val $target.parent().data 'name'
      @suggestions = @fillSuggestions([])

$ -> new App
