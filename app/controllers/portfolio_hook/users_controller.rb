class PortfolioHook::UsersController < PortfolioHookController
  before_action :authenticate_portfolio_user, only: [:update, :destroy, :logged_in]
  before_action :authorize,                   only: [:update, :destroy]
  include ClientFromSubdomainConcern

  def create
    if @client
      user = PortfolioUser.new(user_params)
      user.client = @client

      if user.save
        render json: user
      else
        render json: {
          status: 422,
          msg: 'USER_CREATION_ERROR',
          errors: user.errors
        }
      end
    else
      render json: { status: :unauthorized }
    end
  end

  def logged_in
    if @client
      render json: current_portfolio_user
    else
      render json: { status: :unauthorized }
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :email,
      :password,
      :password_confirmation
    )
  end

  def authorize
    return_unauthorized unless current_portfolio_user && current_portfolio_user.can_modify_user?(params[:id])
  end
end
