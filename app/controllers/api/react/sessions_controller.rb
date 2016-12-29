class Api::React::SessionsController < Api::React::ApiController
  skip_before_action :authenticate_user, only: [:create]
  
  # POST /api/v1/sessions
  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      # User is authorized
      session = Session.new()
      session.user = user
      session.access_token = Session.new_access_token
      session.save
      render json: session, serializer: SessionSerializer, status: :ok
    else
      # Unathorized User
      render json: { errors: ["User with this email doesn't exist or password is wrong"] }, status: :not_found
    end
  end
  
  # DELETE /api/v1/sessions/destroy
  def destroy
    @current_session.destroy
    render json: {}, status: :ok
  end
  
  private
    def user_params
      params.require(:user).permit(:email, :password)
    end
end