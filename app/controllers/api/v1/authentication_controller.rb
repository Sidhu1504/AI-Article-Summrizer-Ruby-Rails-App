class Api::V1::AuthenticationController < ApplicationController
  # This will be an API-only controller
  skip_before_action :verify_authenticity_token

  def social_auth
    # The logic here will depend on your API authentication strategy (e.g., JWT)
    # For now, this is a placeholder
    render json: { message: "Social authentication successful for #{params[:provider]}" }
  end
end
