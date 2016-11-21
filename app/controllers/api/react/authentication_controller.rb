class API::React::AuthenticationController < ApplicationController

  # # POST /api/v1/authentication/sign_in_with_email
  # def sign_in_with_email
  #   # Email is required for Sign In
  #   email = user_params['email']
  #   if email.nil?
  #     render json: { errors: ['Email is missing'] }, status: :bad_request
  #     return
  #   end
  #
  #   # Password is required for Sign In
  #   password = user_params['password']
  #   if password.nil?
  #     render json: { errors: ['Password is missing'] }, status: :bad_request
  #     return
  #   end
  #
  #   user = User.find_by(email: email)
  #   if user && user.authenticate(password)
  #     # User authenticated
  #     # Check if Device exists
  #     device_name = device_params['name']
  #     operational_system = device_params['operational_system']
  #     device = Device.find_by(name: device_name, operational_system: operational_system, owner: user)
  #     if device
  #       if !device.update(device_params)
  #         render json: { errors: ErrorSerializer.serialize(device.errors) }, status: :bad_request
  #         return
  #       end
  #     else
  #       # Create new device, generate access_token and return it to client
  #       device = Device.new(device_params)
  #       device.owner = user
  #       device.access_token = Device.new_access_token
  #       device.save
  #       # Return success response
  #       user_json = UserSerializer.new(user).attributes.as_json
  #       render json: { access_token: device.access_token, user: user_json }, status: :ok
  #       return
  #     end
  #
  #     # Device persisted, regenerate access_token and return it to client
  #     device.access_token = Device.new_access_token
  #     device.save
  #     # Return success response
  #     user_json = UserSerializer.new(user).attributes.as_json
  #     render json: { access_token: device.access_token, user: user_json }, status: :ok
  #   else
  #     # Unathorized User
  #     render json: { errors: ["User with this email doesn't exist or password is wrong"] }, status: :not_found
  #     return
  #   end
  # end
  #
  # private
  #
  #   def user_params
  #     params.require(:user).permit(:email, :password, :password_confirmation)
  #   end
  #
  #   def device_params
  #     params.require(:device).permit(:name, :operational_system)
  #   end
end