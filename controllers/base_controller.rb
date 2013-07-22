class BaseController
  attr :env, :request, :action, :controller

  def call(env)
    @env = env
    @request = Rack::Request.new(env)
    @controller = env['controller']
    @action = env['controller_action']
    _call
  end

  def current_user
    request.session[:user]
  end

  def render(locals={})
    template_opts = { controller: controller, action: action }
    Template.render(template_opts.merge(locals: locals))
  end

  def redirect_to(path)
    @redirect = [301, {'Location' => path, 'Cache-Control' => 'no-cache'}, []]
  end

  private

  def _call
    if action && respond_to?(action)
      result = send(action)
      @redirect || [200, {'Content-Type' => 'text/html'}, [result]]
    else
      [404, {'Content-Type' => 'text/plain'}, ['Not Found']]
    end
  end
end
