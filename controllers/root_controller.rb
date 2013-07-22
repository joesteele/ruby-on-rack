class RootController
  def call(env)
    req = Rack::Request.new(env)
    if req.session[:user] != nil
      [301, {'Location' => Routes::USER, 'Cache-Control' => 'no-cache'}, []]
    else
      [301, {'Location' => Routes::SIGNIN, 'Cache-Control' => 'no-cache'}, []]
    end
  end
end
