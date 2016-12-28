class Api::React::ApiController < ApplicationController
  before_action :authenticate_user
  
  private
    def authenticate_user
      # Check access_token presence
      access_token = request.headers['X-Access-Token']
      if access_token.nil?
        render json: { errors: ['No access token'] }, status: :unauthorized
        return
      end
      
      # Check if Session with this access_token exists
      @current_session = Session.find_by(access_token: access_token)
      if @current_session.nil?
        render json: { errors: ['Session with this access token not found'] }, status: :unauthorized
        return
      end
      
      @current_user = @current_session.user
    end
end