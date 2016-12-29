class Api::React::PagesController < Api::React::ApiController
  skip_before_action :authenticate_user, only: [:index, :show]
  
  # GET api/react/pages
  def index
    pages = Page.order('id DESC')
    render json: pages, each_serializer: PageIndexSerializer, status: :ok
  end
  
  # GET api/react/pages/:id
  def show
    page = Page.find_by!(slug: params[:slug])
    render json: page, serializer: PageShowSerializer, status: :ok
  end
  
  # PUT/PATCH api/react/pages/:id
  def update
    page = Page.find_by!(slug: params[:slug])
    if page.update(page_params)
      render json: page, serializer: PageShowSerializer, status: :ok
    else
      render json: { errors: page.errors.full_messages }, status: :bad_request
    end
  end
  
  private
    def page_params
      params.require(:page).permit(:content, :html_content)
    end
end