class Redundamail.Views.EmailsIndex extends Backbone.View

  template: JST['emails/index']
  _modelBinder: undefined
  
  events: 
    "click button.submit": "submit"

  
  initialize: ->
    @emails = new Redundamail.Collections.Emails({})
    @_modelBinder = new Backbone.ModelBinder()
    @listenTo(@emails, 'add', @addEmail);
    @emails.fetch()
    
    @model = new Redundamail.Models.Email({});
    @listenTo(@model, 'change', @checkComplete);
    
  checkComplete:(model) ->
    @model.get("to_email") && @model.get("from_email") && @model.get("body") && @model.get("subject") && @model.get("provider")

      
  addEmail:(model) ->
    valid_template = JST['emails/valid_attempt']
    invalid_template = JST['emails/invalid_attempt']
    attempts = @$el.find("#attempts")
    unless model.get("sent") is false
      attempts.prepend valid_template()
    else
      attempts.prepend invalid_template()
    
  render: ->
    @$el.html( @template() )
    bindings =
      to_email: "#to_email"
      from_email: "#from_email"
      body: "#body"
      subject: "#subject"
      provider: "#provider"
      
    @_modelBinder.bind(@model, @el, bindings)
    return @
    
  submit:(e) ->

    e.preventDefault
    e.stopPropagation
    _self=@
    if @checkComplete()
      @$el.find("#not_finished").addClass("hide")
      @model.save({},
        success:(model, response) ->
          console.log "inside model save success"
          _self.emails.add(_self.model)
          _self.model.clear()
          _self.$el.find("#errors_found").addClass("hide")
        error:(model, response) ->
          console.log "inside model save error"
          _self.$el.find("#errors_found").removeClass("hide")
      )
      return
    else
      @$el.find("#errors_found").addClass("hide")
      @$el.find("#not_finished").removeClass("hide")
      return