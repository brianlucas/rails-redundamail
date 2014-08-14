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


## To-Do
Add test cases for both model and email services
Add additional error logging on Backbone when errors are detected
Add validation on Backbone front-end  (Backbone.Validation)

