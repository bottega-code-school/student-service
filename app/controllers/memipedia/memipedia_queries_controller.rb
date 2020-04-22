class Memipedia::MemipediaQueriesController < MobileApplicationController
  before_action :authenticate_memipedia_user
  include ClientFromSubdomainConcern

  def index
    if @client
      if params[:query]
        render json: @client
                       .memipedia_posts
                       .search_by_term(params[:query])
      else
        render json: { error_message: "A query is required" }
      end
    else
      render json: { status: :unauthorized }
    end
  end
end
