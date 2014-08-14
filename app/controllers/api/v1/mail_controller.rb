module Api
   module V1
     class MailController < BaseController
       respond_to :json
       
       def index
         @emails = Email.all
         respond_with @emails
       end
       
       def create
         @email = Email.create(filtered_params)
         @email.dispatch
         respond_with @email
       end
       
       private
       
       def filtered_params
         params.permit(:to_email, :from_email, :body, :subject, :provider)
       end
     end
   end
end
