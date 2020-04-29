class Portfolio::AppPortfolioUsersController < ApplicationController
  include ClientFromSubdomainConcern

  def index
    if @client
      render json: {
        app_portfolio_users: devcamp_space_serializer(@client)
      }
    else
      render json: { status: :unauthorized }
    end
  end

  def create
    if @client
      user = PortfolioUser.new(user_params)
      user.client = @client

      if user.save
        render json: {
          app_portfolio_user: serializer_user(user),
          status: :created
        }
      else
        render json: user.errors, status: :unprocessable_entity
      end
    else
      render json: { status: :unauthorized }
    end
  end

  def destroy
    if @client
      user = PortfolioUser.find(params[:id])

      if user && user.client == @client
        user.destroy
        render json: { status: 200, msg: 'User has been deleted.' }
      end
    else
      render json: { status: :unauthorized }
    end
  end

  private

  def serializer_user user
    user_object = Hash.new.as_json
    user_object[:id] = user.id
    user_object[:email] = user.email
    user_object[:password] = "ENCRYPTED"
    user_object[:password_confirmation] = "ENCRYPTED"
    user_object[:created_at] = user.created_at
    user_object[:column_names_merged_with_images] = [
      'id',
      'email',
      'password',
      'password_confirmation'
    ]
    user_object
  end

  def devcamp_space_serializer client
    users = client.portfolio_users

    if users.any?
      users.map do |user|
        serializer_user user
      end
    else
      user_object = Hash.new.as_json
      user_object[:id] = 123
      user_object[:email] = "user@example.com"
      user_object[:password] = "ENCRYPTED"
      user_object[:password_confirmation] = "ENCRYPTED"
      user_object[:column_names_merged_with_images] = [
        'id',
        'email',
        'password',
        'password_confirmation'
      ]
      [user_object]
    end
  end

  def user_params
    params.require(:app_portfolio_user).permit(
      :email,
      :password,
      :password_confirmation
    )
  end
end
