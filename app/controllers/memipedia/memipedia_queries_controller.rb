class Memipedia::MemipediaQueriesController < MobileApplicationController
  before_action :authenticate_memipedia_user
  include ClientFromSubdomainConcern

  def index
    # TODO
    if @client
      render json: @client.memipedia_posts.order(created_at: :desc)
    else
      render json: { status: :unauthorized }
    end
  end
end
