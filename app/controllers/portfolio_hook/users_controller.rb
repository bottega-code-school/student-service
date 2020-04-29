class PortfolioHook::UsersController < PortfolioHookController
  before_action :authenticate_portfolio_user
  include ClientFromSubdomainConcern

  def logged_in
    if @client
      render json: current_portfolio_user
    else
      render json: { status: :unauthorized }
    end
  end
end
