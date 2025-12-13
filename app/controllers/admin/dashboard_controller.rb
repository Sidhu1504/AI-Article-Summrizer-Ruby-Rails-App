class Admin::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin!

  def index
    # Add logic for your admin dashboard here
  end

  private

  def ensure_admin!
    # Add logic to ensure the user is an admin
    # For example, you could add an `admin` boolean to the User model
    redirect_to root_path unless current_user.admin?
  end
end
