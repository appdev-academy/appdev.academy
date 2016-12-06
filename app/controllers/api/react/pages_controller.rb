class Api::React::PagesController < Api::React::ApiController
  skip_before_action :authenticate_user, only: [:index, :show]
  
  # GET api/react/pages
  def index
    pages = Page.order('id DESC')
    pages_json = ActiveModel::Serializer::CollectionSerializer.new(pages, each_serializer: PageIndexSerializer).as_json
    render json: pages_json, status: :ok
  end
  
  # GET api/react/pages/:id
  def show
    page = Page.find(params[:id])
    page_json = PageShowSerializer.new(page).attributes.as_json
    render json: page_json, status: :ok
  end
  
  # PUT/PATCH api/react/pages/:id
  def update
    page = Page.find(params[:id])
    if page.update(page_params)
      page_json = PageShowSerializer.new(page).attributes.as_json
      render json: page_json, status: :ok
    else
      render json: { errors: page.errors.full_messages }, status: :bad_request
    end
  end
  
  private
  
    def page_params
      params.require(:page).permit(:content, :html_content)
    end
end