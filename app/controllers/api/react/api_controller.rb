class Api::React::ApiController < ApplicationController
  # before_action :authenticate
  
  def current_user
    @current_user
  end
  
  def current_device
    @current_device
  end
  
  def signed_in?
    @current_user != nil
  end
  
  private
    
    def authenticate
      # Check access_token presence
      access_token = request.headers['X-Device-Token']
      if access_token.nil?
        render json: { errors: ['No access token in header'] }, status: :unauthorized
        return
      end
      
      # Check if Device with this access_token exists
      @current_device = Device.find_by(access_token: access_token)
      if @current_device.nil?
        render json: { errors: ['Device with this token not found'] }, status: :unauthorized
        return
      end
      
      @current_user = @current_device.owner
    end
end