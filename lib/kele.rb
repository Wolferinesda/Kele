require 'httparty'
# require httparty to load when file is loaded
require 'json'

class Kele
# Createing Kele class to set basis for kele function
  include HTTParty
# includes HTTParty when the class loads
  base_uri 'https://www.bloc.io/api/v1'
# the base api url so that Kele loads the bloc url for the code to use
  def initialize(email, password)
# new initialize method to process the emails and passwords entered
    post_response = self.class.post('/sessions', body: {
      email: email,
      password: password
    })
    @user_auth_token = post_response['auth_token']
# posts the email and password created
    raise "Invalid Email or Password. Try Again." if @user_auth_token.nil?
# gives error if the token is nil
  end

  def get_me
    response = self.class.get('/users/me', headers: { "authorization" => @user_auth_token })
    response_parse = JSON.parse(response.body)
  end

end
