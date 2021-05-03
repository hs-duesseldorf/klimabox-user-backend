module Restriction
  extend ActiveSupport::Concern

  def check_for_access
    return if current_user.admin

    flash[:error] = "Du hast keine Berechtigung für diesen Bereich."
    redirect_back(fallback_location: frontend_root_path)
  end
end