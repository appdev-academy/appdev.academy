class Api::React::TagsController < Api::React::ApiController
  # GET api/react/tags
  def index
    tags = Tag.all
    render json: tags, each_serializer: TagSerializer, status: :ok
  end
end
