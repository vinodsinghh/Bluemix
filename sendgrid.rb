require 'rubygems'
require 'sinatra'
require 'haml'
require 'mail'

get '/' do
  
  @msg = 'Hello from SendGrid Service attach with Ruby App'
  haml :header 
  #step 1: Initialize SendGrid credentials from SendGrid service instance 
  
#sendgrid_user = JSON.parse(ENV['VCAP_SERVICES'])['sendgrid'].first['credentials']['username']
#sendgrid_password = JSON.parse(ENV['VCAP_SERVICES'])['sendgrid'].first['credentials']['password']
#sendgrid_hostname = JSON.parse(ENV['VCAP_SERVICES'])['sendgrid'].first['credentials']['hostname']

# IBM Bluemix
#sendgrid_user='c7hh3i9OM7'
#sendgrid_password='CvMXOPZpp3'
#sendgrid_hostname='smtp.sendgrid.net'

sendgrid_user='jeGmZTT9MI'
sendgrid_password='ng4aIrkrWt'
sendgrid_hostname='smtp.sendgrid.net'

  #step 2: call sendgrid REST APIs for sending e-mail
  # Reference : https://sendgrid.com/docs/Code_Examples/ruby.html
   
  Mail.defaults do
    delivery_method :smtp, { :address   => "smtp.sendgrid.net",
                             :port      => 587,
                             :domain    => sendgrid_hostname,
                             :user_name => sendgrid_user,
                             :password  => sendgrid_password,
                             :authentication => 'plain',
                             :enable_starttls_auto => true }
  end
  
  @msg = 'Sending Mail'
  mail = Mail.deliver do
    to 'vinoddandy@gmail.com'
    from 'Vinod Kumar Singh <vinoksin@in.ibm.com>'
    subject 'SENDGRID Service'
    text_part do
      body 'Hello world in text from SendGrid service'
    end
    html_part do
      content_type 'text/html; charset=UTF-8'
      body '<b>Hello world in HTML from SendGrid service</b>'
    end

  end
  @msg = 'mail sent successfully' 
  haml :footer
    
  

  
end




