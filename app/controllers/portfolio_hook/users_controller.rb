class PortfolioHook::UsersController < PortfolioHookController
  before_action :authenticate_portfolio_user

  def logged_in
    puts "current_portfolio_user" * 100, current_portfolio_user.inspect

    if current_portfolio_user
      render json: current_portfolio_user
    else
      render json: { status: :unauthorized }
    end
  end
end
