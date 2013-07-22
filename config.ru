require 'rubygems'
require 'bundler'
Bundler.require
Dotenv.load
require './app'

use Rack::Static, urls: ['/bootstrap'], root: 'public'
# CHANGE YOUR SESSION KEY
use Rack::Session::Cookie, key: '_rack_demo.session', secret: 'f06536845fadc9417d39376e96b96fe00474e9831b9b52e200e60b0ff114d11fb4b9f435977cef60618a077a8b33744ef882bac7f6dcf6ea7bdb7e22193ee0db99025cb1cce81f422dfdaa0d4ffa6dd36b6b7f4fbe429da2ed447a2824c20dc7946fb2f912e4e0eaa7f6a9d9ef7d26e4a8ddbbdd62249ce0699cbc84385dfd07'
use OmniAuth::Builder do
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']
end

run RackDemo::App.new