class Api::React::PagesController < Api::React::ApiController
  skip_before_action :authenticate_user, only: [:index, :show]
  
  # GET api/react/pages
  def index
    pages = Page.order('id DESC')
    render json: pages, each_serializer: PageSerializer, status: :ok
  end
  
  # PUT/PATCH api/react/pages/:id
  def update
    page = Page.find(params[:id])
    if page.update(page_params)
      render json: page, serializer: PageSerializer, status: :ok
    else
      render json: { errors: page.errors.full_messages }, status: :bad_request
    end
  end
  
  private
  
    def page_params
      params.require(:page).permit(:content, :html_content)
    end
end