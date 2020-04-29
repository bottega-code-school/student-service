class Portfolio::PortfolioItemsController < ApplicationController
  before_action :set_portfolio_item, only: [:show, :edit, :update, :destroy]
  include AuthenticationConcern
  include ClientFromSubdomainConcern

  def index
    if params[:order_by] && params[:direction]
      @portfolio_items = @client.portfolio_items.order("#{params[:order_by]} #{params[:direction]}")
    else
      @portfolio_items = @client.portfolio_items.order(id: :asc)
    end

    if @portfolio_items.count == 0
      @portfolio_items = [PortfolioItem.new]
    end

    render json: @portfolio_items
  end

  def show
    render json: @portfolio_item
  end

  # GET /portfolio_items/new
  def new
    @portfolio_item = PortfolioItem.new
  end

  # GET /portfolio_items/1/edit
  def edit
  end

  def create
    if @current_client && @current_client == @client
      @portfolio_item = @client.portfolio_items.new(portfolio_item_params)

      if @portfolio_item.save
        render json: @portfolio_item, status: :created
      else
        render json: @portfolio_item.errors, status: :unprocessable_entity
      end
    else
      render json: { status: :unauthorized }
    end
  end

  def update
    if @current_client && @portfolio_item.client == @current_client
      if @portfolio_item.update(portfolio_item_params)
        render json: @portfolio_item, status: :created
      else
        render json: @portfolio_item.errors, status: :unprocessable_entity
      end
    else
      render json: { status: :unauthorized }
    end
  end

  def destroy
    if @portfolio_item.client == @current_client
      @portfolio_item.destroy
      render json: { msg: "RECORD_DELETED" }
    else
      render json: { status: :unauthorized }
    end
  end

  private
    def set_portfolio_item
      @portfolio_item = PortfolioItem.find(params[:id])
    end

    def portfolio_item_params
      params.require(:portfolio_item).permit(
        :name,
        :description,
        :url,
        :thumb_image,
        :banner_image,
        :logo,
        :category,
        :position
      )
    end
end
