class Router
  def self.routes
    @routes ||= {}
  end

  def self.configure(&block)
    instance_eval(&block) if block_given?
  end

  def self.map(route, opts={})
    routes[route] = opts
  end

  def initialize
    @app = Rack::Builder.new do
      use Middleware
      run Dispatcher.new
    end.to_app
  end

  def call(env)
    @app.call(env)
  end

  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      req = Rack::Request.new(env)
      route = Router.routes[req.path_info] || {}
      env['controller'] = route[:controller] || 'base'
      env['controller_action'] = route[:action]
      @app.call(env)
    end
  end

  class Dispatcher
    def call(env)
      controller_name = env['controller'].capitalize + 'Controller'
      controller = Object.const_get(controller_name).new
      controller.call(env)
    end
  end
end
