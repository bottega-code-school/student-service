class PortfolioHook::PortfolioItems::PositionController < PortfolioHookController
  before_action :set_portfolio_item
  before_action :authenticate_client

  def update
    puts "current_portfolio_user" * 100, current_portfolio_user.inspect, "current_portfolio_user" * 100
    puts "portfolio_item" * 100, @portfolio_item.inspect, "portfolio_item" * 100
    puts "portfolio_item client" * 100, @portfolio_item.client.inspect, "portfolio_item client" * 100
    if @portfolio_item.client == current_client
      if @portfolio_item.update(position_position: params[:position])
        render json: @portfolio_item, status: :updated
      else
        render json: @portfolio_item.errors, status: :unprocessable_entity
      end
    else
      render json: { status: :unauthorized }
    end
  end

  private

    def set_portfolio_item
      @portfolio_item = PortfolioItem.find(params[:portfolio_item_id])
    end
end
