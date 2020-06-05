class AuthTokensController < MobileApplicationController
  before_action :authenticate_client

  def logged_in
    if current_client
      render json: current_client
    else
      render json: { status: :unauthorized }
    end
  end
end
