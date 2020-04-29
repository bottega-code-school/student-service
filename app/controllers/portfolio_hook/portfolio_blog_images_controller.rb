class PortfolioHook::PortfolioBlogImagesController < PortfolioHookController
  before_action :set_portfolio_blog, only: [:destroy]
  include AuthenticationConcern

  def destroy
    list_of_images = ["featured_image"]

    if @portfolio_blog.client == @current_client
      if params["image_type"] && list_of_images.include?(params["image_type"])
        @portfolio_blog.send(params["image_type"]).purge
        render json: { status: 204 }
      else
        render json: { status: :unprocessable_entity }
      end
    else
      render json: { status: :unauthorized }
    end
  end

  private
    def set_portfolio_blog
      @portfolio_blog = PortfolioBlog.find(params[:id])
    end
end
