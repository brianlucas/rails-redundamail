module Api
  module V1
    class BaseController < ActionController::Base
      skip_before_filter :verify_authenticity_token
      include ActionController::RequestForgeryProtection
      include ActionController::MimeResponds
      include ActionController::ImplicitRender
      
      self.responder = ApiResponder
    end
  end
end
