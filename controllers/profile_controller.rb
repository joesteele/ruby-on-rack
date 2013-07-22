class ProfileController
  def call(env)
    req = Rack::Request.new(env)
    user = req.session[:user]
    view = Template.render(controller: 'profile',
                           action: 'show',
                           locals: {user: user})
    [200, {'Content-Type' => 'text/html'}, [view]]
  end
end

