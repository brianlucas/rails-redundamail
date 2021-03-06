require 'net/http'
require "uri" 
class Email < ActiveRecord::Base
  enum provider: [ :all_providers, :mandrill, :mailgun ]

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  # validations
  validates :to_email,
    :presence => {:message => "Please check your email"},
    :format => { :with => VALID_EMAIL_REGEX, :message=>"Please check the formatting of your email address" }
  validates :from_email,
    :presence => {:message => "Please check your email"},
    :format => { :with => VALID_EMAIL_REGEX, :message=>"Please check the formatting of your email address" }

  # responsible for sending the email with content in the model
  def dispatch
    @sent = self.sent ? self.sent : false

    case provider.to_sym
    when :all_providers
      mandrill_dispatch unless @sent
      mailgun_dispatch unless @sent
    when :mandrill
      mandrill_dispatch unless @sent
    when :mailgun
      mailgun_dispatch unless @sent
    end
    self.update(sent:@sent)
  end
  
  # TO-DO: Refactor both mandrill and mailgun into single DRY library with unique attributes per mail service
  
  def mandrill_dispatch

    # Mandrill URL
    uri = URI.parse("https://mandrillapp.com/api/1.0/messages/send.json")

    # initiate request
    Net::HTTP.start(uri.host, uri.port,
      :use_ssl => uri.scheme == 'https') do |http|

      request = Net::HTTP::Post.new uri
      body="#{self.body} \r\n- sent via Mandrill"

      ## TO-DO: Remove secure key and place in secure place
      params = {"key" => "b_X4qhErhOzLxdqcpOqCNg",
        "message" => { 
          "html" => body, 
          "text" => body, 
          "subject" => subject, 
          "from_email" => from_email,
          "to" => [{"email" => to_email, "type" => "to"}]
        }
      }
      request.body = params.to_json

      response = http.request request # Net::HTTPResponse object
      # output response
      puts response.code
      puts response.body

      # if we received HTTP 200 it was sent
      if response.code.eql?("200")
        @sent=true
      else
        # respond back with error
        errors.add(:base, response.body)
      end
    end
    
    @sent
  end
  
  def mailgun_dispatch
    # Mailgun URL
    uri = URI.parse("https://api.mailgun.net/v2/sandbox14629c98dedb4deda8554f17e8aa137e.mailgun.org/messages")

    # initiate request
    Net::HTTP.start(uri.host, uri.port,
      :use_ssl => uri.scheme == 'https') do |http|
        
      request = Net::HTTP::Post.new uri
      body="#{self.body} \r\n- sent via Mailgun"

      ## TO-DO: Remove secure key and place in secure place
      request.basic_auth("api", "key-92acb01849558bf360aa18812017c9b8")
      request.set_form_data({"text" => body, "subject" => subject, "from" => from_email, "to" => to_email})
  
      response = http.request request # Net::HTTPResponse object
      # output response
      puts response.code
      puts response.body
      
      # if we received HTTP 200 it was sent
      if response.code.eql?("200")
        @sent=true
      else
        # respond back with error
        errors.add(:base, response.body)
      end

    end
    
    @sent
  end
  
end
