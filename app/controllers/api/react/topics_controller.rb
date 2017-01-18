class Api::React::TopicsController < Api::React::ApiController
  # GET api/react/topics
  def index
    topics = Topic.order('position DESC')
    render json: topics, each_serializer: TopicSerializer, status: :ok
  end
  
  # GET api/react/topics/:id
  def show
    topic = Topic.find(params[:id])
    render json: topic, serializer: TopicSerializer, status: :ok
  end
  
  # POST api/react/topics
  def create
    topic = Topic.new(topic_params)
    if topic.save
      render json: topic, serializer: TopicSerializer, status: :ok
    else
      render json: { errors: topic.errors.full_messages }, status: :bad_request
    end
  end
  
  # PUT/PATCH api/react/topics/:id
  def update
    topic = Topic.find(params[:id])
    if topic.update(topic_params)
      render json: topic, serializer: TopicSerializer, status: :ok
    else
      render json: { errors: topic.errors.full_messages }, status: :bad_request
    end
  end
  
  # DELETE api/react/topics/:id
  def destroy
    topic = Topic.find(params[:id])
    topic.destroy
    render json: {}, status: :ok
  end
  
  # POST api/react/topics/:id/publish
  def publish
    topic = Topic.find(params[:id])
    topic.is_hidden = false
    if topic.save
      render json: topic, serializer: TopicSerializer, status: :ok
    else
      render json: { errors: topic.errors.full_messages }, status: :bad_request
    end
  end
  
  # POST api/react/topics/:id/hide
  def hide
    topic = Topic.find(params[:id])
    topic.is_hidden = true
    if topic.save
      render json: topic, serializer: TopicSerializer, status: :ok
    else
      render json: { errors: topic.errors.full_messages }, status: :bad_request
    end
  end
  
  # POST api/react/topics/sort
  def sort
    params[:topic_ids].reverse.each_with_index do |id, index|
      Topic.where(id: id).update_all(position: index + 1)
    end
    render json: {}, status: :ok
  end
  
  private
    def topic_params
      params.require(:topic).permit(:slug, :title)
    end
end
