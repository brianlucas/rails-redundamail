# app/responders/api_responder.rb
class ApiResponder < ActionController::Responder
  def to_format

    case
    when has_errors?
      status=:unprocessable_entity
      status=@resource.status.presence || :unprocessable_entity if @resource.respond_to?('status')
      return render json: {
        error: @resource.errors },
        status: status
    else

      @response=controller.response
      default_render 
    end
    
  rescue ActionView::MissingTemplate => e
    puts "inside rescue ActionView::MissingTemplate: #{e}"
    begin
      api_behavior(e)
    rescue Exception=>e
      puts "inside Exception: #{e}"
      # TO-DO: decide if this is a security risk
      render json: @resource.to_json
    end
  end
  
  
end