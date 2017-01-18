class Api::React::LessonsController < Api::React::ApiController
  # GET api/react/screencasts/:screencast_id/lessons
  def index
    lessons = Lesson.where(screencast_id: params[:screencast_id]).order('position DESC')
    render json: lessons, each_serializer: LessonIndexSerializer, status: :ok
  end
  
  # GET api/react/lessons/:id
  def show
    lesson = Lesson.find(params[:id])
    render json: lesson, serializer: LessonShowSerializer, status: :ok
  end
  
  # POST api/react/screencasts/:screencast_id/lessons
  def create
    screencast = Screencast.find(params[:screencast_id])
    lesson = Lesson.new(lesson_params)
    lesson.screencast = screencast
    if lesson.save
      render json: lesson, serializer: LessonShowSerializer, status: :ok
    else
      render json: { errors: lesson.errors.full_messages }, status: :bad_request
    end
  end
  
  # PUT/PATCH api/react/lessons/:id
  def update
    lesson = Lesson.find(params[:id])
    if lesson.update(lesson_params)
      render json: lesson, serializer: LessonShowSerializer, status: :ok
    else
      render json: { errors: lesson.errors.full_messages }, status: :bad_request
    end
  end
  
  # DELETE api/react/lessons/:id
  def destroy
    lesson = Lesson.find(params[:id])
    lesson.destroy
    render json: {}, status: :ok
  end
  
  # POST api/react/lessons/:id/publish
  def publish
    lesson = Lesson.find(params[:id])
    lesson.is_hidden = false
    if lesson.save
      render json: lesson, serializer: LessonShowSerializer, status: :ok
    else
      render json: { errors: lesson.errors.full_messages }, status: :bad_request
    end
  end
  
  # POST api/react/lessons/:id/hide
  def hide
    lesson = Lesson.find(params[:id])
    lesson.is_hidden = true
    if lesson.save
      render json: lesson, serializer: LessonShowSerializer, status: :ok
    else
      render json: { errors: lesson.errors.full_messages }, status: :bad_request
    end
  end
  
  # POST api/react/screencasts/:screencast_id/lessons/sort
  def sort
    params[:lesson_ids].reverse.each_with_index do |id, index|
      Lesson.where(id: id).update_all(position: index + 1)
    end
    render json: {}, status: :ok
  end
  
  private
    def lesson_params
      params.require(:lesson).permit(:content, :html_content, :html_preview, :image_url, :preview, :short_description, :title)
    end
end
