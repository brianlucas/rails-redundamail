rails-redundamail
=================

Redundant Email Sending Service Mockup

This sends emails via a form through two services: 
Mandrill [http://www.mandrill.com]
Mailgun [http://www.mailgun.com]

## Instructions
Installation is simple.  Clone the project and run the following:

``` 
bundle install
rake db:setup
```

Visit the server on your web browser.  You can enter the following attributes:
- From Email
- To Email
- Subject
- Body
- Email Delivery Service or leave default for both

## Instructions
A demo is hosted on Heroku at: http://redundamail.herokuapp.com/

## Non-Boilerplate code
The following code was added beyond the default Rails boilerplate code to make this application work:

#### CSS:
- Bootstrap theme Flatly taken from http://bootswatch.com

#### Backbone:
- Adapters: /assets/javascripts/adapters/backbone.modelbinder.js - Binds Views/Templates to a model for save/updates to server
- Router: /assets/javascripts/routers/emails_router.js - This contains the bootup and initial rendering / routing for the application.
- Views: /assets/javascripts/views/emails/emails_index.js - This is responsible for the controller logic of the application and painting the views/templates
- Models: /assets/javascripts/models/email.js - Responsible for data modeling of email attributes to/from server

#### Rails:
- /app/responders/api_responder.rb - Handles API responses for RESTful requests
- /app/controllers/api/v1/mail_controller.rb - API code responsible for handling GET/POST requests
- /app/models/email.rb - This handles data persistence to PostgreSQL and also manages email dispatch (Mandrill/Mailgun) of the email data

## To-Do
- Add test cases for both model and email services
- Add additional error logging on Backbone when errors are detected
- Add validation on Backbone front-end  (Backbone.Validation)

