require 'rubygems'
require 'bundler'
Bundler.require
Dotenv.load

use Rack::Static, urls: ['/bootstrap'], root: 'public'
# CHANGE YOUR SESSION KEY
use Rack::Session::Cookie, key: '_rack_demo.session', secret: 'f06536845fadc9417d39376e96b96fe00474e9831b9b52e200e60b0ff114d11fb4b9f435977cef60618a077a8b33744ef882bac7f6dcf6ea7bdb7e22193ee0db99025cb1cce81f422dfdaa0d4ffa6dd36b6b7f4fbe429da2ed447a2824c20dc7946fb2f912e4e0eaa7f6a9d9ef7d26e4a8ddbbdd62249ce0699cbc84385dfd07'
use OmniAuth::Builder do
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']
end

class User
  attr_accessor :id, :name, :nickname, :image

  def self.from_auth(auth)
    new.tap do |user|
      user.id = auth[:uid]
      user.name = auth[:info][:name]
      user.nickname = auth[:info][:nickname]
      user.image = auth[:info][:image]
    end
  end
end

class Demo
  USER_TEMPLATE = Erubis::Eruby.new(File.read('user.html.erb'))
  ROOT_PATH = '/'
  USER_PATH = '/user'
  SIGNIN_PATH = '/sign-in'
  SIGNOUT_PATH = '/sign-out'
  AUTH_CALLBACK_PATH = '/auth/github/callback'

  def call(env)
    req = Rack::Request.new(env)
    case req.path_info
    when USER_PATH
      body = USER_TEMPLATE.result(user: req.session[:user]).to_s
      [200, {'Content-Type' => 'text/html'}, [body]]
    when SIGNIN_PATH
      [200, {'Content-Type' => 'text/html'}, [File.read('public/signin.html').to_s]]
    when SIGNOUT_PATH
      req.session[:user] = nil
      [301, {'Location' => SIGNIN_PATH}, []]
    when AUTH_CALLBACK_PATH
      req.session[:user] = User.from_auth(env['omniauth.auth'])
      [301, {'Location' => USER_PATH}, []]
    when ROOT_PATH
      if req.session[:user] != nil
        [301, {'Location' => USER_PATH}, []]
      else
        [301, {'Location' => SIGNIN_PATH}, []]
      end
    else
      [404, {'Content-Type' => 'text/plain'}, ['Not Found']]
    end
  end
end

run Demo.new