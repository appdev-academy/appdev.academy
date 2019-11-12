class Api::React::EstimateRequestsController < Api::React::ApiController
  # POST api/react/estimate_requests
  def create
    estimate_request = EstimateRequest.new(estimate_request_params)
    if estimate_request.save
      render json: estimate_request, serializer: EstimateRequestSerializer, status: :ok
    else
      render json: { errors: estimate_request.errors.full_messages }, status: :bad_request
    end
  end
  
  private
  
  def estimate_request_params
    params.require(:estimate_request).permit(:budget, :company, :deadline, :details, :documen, :email, :is_admin_panel, :is_android, :is_backend_api, :is_design, :is_ios, :is_other, :name, :subject)
  end
end
