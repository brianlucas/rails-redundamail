window.Redundamail =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: ->
    @Routers.app = new Redundamail.Routers.Emails({$el: "#content"})
    Backbone.history.start
      pushState: true
      root: "/"
    
$(document).ready ->
  Redundamail.initialize()
