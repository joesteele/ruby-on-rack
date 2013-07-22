require 'rack'
class App
  def call(env)
    [200, {}, ['Hello World from Rack Demo 2!']]
  end
end

run App.new
