class ProfileController < BaseController
  def show
    render user: current_user
  end
end
