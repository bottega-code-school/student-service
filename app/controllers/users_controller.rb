class Memipedia::MemipediaUsersController < MobileApplicationController
  before_action :authenticate_memipedia_user, only: [:update, :destroy, :logged_in]
  before_action :authorize,                   only: [:update, :destroy]
  include ClientFromSubdomainConcern

  def create
    if @client
      user = MemipediaUser.new(user_params)
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

  def update
    # TODO
    user = MemipediaUser.find(params[:id])

    if user.update(user_params)
      render json: user
    else
      render json: {
        status: 422,
        msg: 'ERROR_UPDATING'
      }
    end
  end

  def logged_in
    if @client
      render json: current_memipedia_user
    else
      render json: { status: :unauthorized }
    end
  end

  def destroy
    user = MemipediaUser.find(params[:id])
    if user.destroy
      render json: { status: 200, msg: 'User has been deleted.' }
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
    return_unauthorized unless current_memipedia_user && current_memipedia_user.can_modify_user?(params[:id])
  end
end
