class SessionsController < BaseController
  def new
    render
  end

  def create
    request.session[:user] = User.from_auth(env['omniauth.auth'])
    redirect_to '/'
  end

  def destroy
    request.session[:user] = nil
    redirect_to '/'
  end
end
