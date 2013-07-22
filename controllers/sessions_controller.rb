class SessionsController
  def call(env)
    case request(env).path_info
    when Routes::SIGNIN then new_session
    when Routes::SIGNOUT then destroy_session(env)
    when Routes::AUTH_CALLBACK then create_session(env)
    else DEMO::NOT_FOUND
    end
  end

  def new_session
    view = Template.render(controller: 'sessions', action: 'signin')
    [200, {'Content-Type' => 'text/html'}, [view]]
  end

  def create_session(env)
    request(env).session[:user] = User.from_auth(env['omniauth.auth'])
    redirect_to_root
  end

  def destroy_session(env)
    request(env).session[:user] = nil
    redirect_to_root
  end

  def redirect_to_root
    [301, {'Location' => Routes::ROOT, 'Cache-Control' => 'no-cache'}, []]
  end

  def request(env)
    Rack::Request.new(env)
  end
end

