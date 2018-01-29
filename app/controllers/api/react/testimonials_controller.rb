class Api::React::TestimonialsController < Api::React::ApiController
  before_action :set_testimonial, only: [:show, :update, :destroy, :publish, :hide]
  
  # GET api/react/testimonials
  def index
    testimonials = Testimonial.order('position DESC').limit(100)
    testimonials_json = ActiveModel::Serializer::CollectionSerializer.new(testimonials, serializer: TestimonialIndexSerializer).as_json
    render json: { testimonials: testimonials_json }, status: :ok
  end
  
  # GET api/react/testimonials/:id
  def show
    testimonial_json = TestimonialShowSerializer.new(@testimonial).as_json
    render json: { testimonial: testimonial_json }, status: :ok
  end
  
  # POST api/react/testimonials
  def create
    testimonial = Testimonial.new(testimonial_params)
    
    if testimonial.save
      testimonial_json = TestimonialShowSerializer.new(testimonial).as_json
      render json: { testimonial: testimonial_json }, status: :created
    else
      render json: { errors: testimonial.errors.full_messages }, status: :unprocessable_entity
    end
  end
  
  # PUT/PATCH api/react/testimonials/:id
  def update
    if @testimonial.update(testimonial_params)
      testimonial_json = TestimonialShowSerializer.new(@testimonial).as_json
      render json: { testimonial: testimonial_json }, status: :ok
    else
      render json: { errors: @testimonial.errors.full_messages }, status: :unprocessable_entity
    end
  end
  
  # DELETE api/react/testimonials/:id
  def destroy
    @testimonial.destroy
    render json: { success: true }, status: :ok
  end
  
  # POST api/react/testimonials/:id/publish
  def publish
    if @testimonial.update(published: true)
      testimonial_json = TestimonialShowSerializer.new(@testimonial).as_json
      render json: { testimonial: testimonial_json }, status: :ok
    else
      render json: { errors: @testimonial.errors.full_messages }, status: :unprocessable_entity
    end
  end
  
  # POST api/react/testimonials/:id/hide
  def hide
    if @testimonial.update(published: false)
      testimonial_json = TestimonialShowSerializer.new(@testimonial).as_json
      render json: { testimonial: testimonial_json }, status: :ok
    else
      render json: { errors: @testimonial.errors.full_messages }, status: :unprocessable_entity
    end
  end
  
  # POST api/react/testimonials/sort
  def sort
    params[:testimonial_ids].reverse.each_with_index do |id, index|
      Testimonial.where(id: id).update_all(position: index + 1)
    end
    render json: { success: true }, status: :ok
  end
  
  private
    def set_testimonial
      @testimonial = Testimonial.find(params[:id])
    end
    
    def testimonial_params
      params.require(:testimonial).permit(:body, :company, :first_name, :html_body, :last_name, :profile_picture, :title)
    end
end
