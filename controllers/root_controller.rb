class RootController < BaseController
  def index
    if current_user
      redirect_to '/user'
    else
      redirect_to '/sign-in'
    end
  end
end
