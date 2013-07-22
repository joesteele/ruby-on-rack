module RackDemo
  ROOT = File.dirname(__FILE__)
end

Dir.glob("{models,controllers}/*").each do |file|
  require File.join(RackDemo::ROOT, file)
end

module RackDemo
  class App
    def initialize
      @app = Router.new
    end

    def call(env)
      @app.call(env)
    end
  end
end
