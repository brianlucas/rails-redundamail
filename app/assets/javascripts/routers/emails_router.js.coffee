class Redundamail.Routers.Emails extends Backbone.Router

  constructor: (options) ->
    @options = options
    Backbone.Router.call this, options
    
  routes: 
    "": "emailView"
  
  initialize: ->
    _content = @options.$el
    @$content = $(_content)
    
  emailView: ->
    @emailView = new Redundamail.Views.EmailsIndex()
    @render @emailView
    return

  render: (view, options) ->

    # First we inject the element into the HTML to avoid issues with resizing
    @$content.html view.el
    
    # Next we call render on the new view
    @currentView = view
    view.render()
    $window = $(window)
    $window.scrollTop 0
    return