class Api::React::EstimateRequestsController < Api::React::ApiController
  # GET /api/react/estimate_requests
  def index
    estimate_requests = EstimateRequest.order('created_at DESC')
    render json: estimate_requests, each_serializer: EstimateRequestSerializer, status: :ok
  end
  
  # GET /api/react/estimate_requests/:id
  def show
    estimate_request = EstimateRequest.find(params[:id])
    render json: estimate_request, serializer: EstimateRequestSerializer, status: :ok
  end
end
