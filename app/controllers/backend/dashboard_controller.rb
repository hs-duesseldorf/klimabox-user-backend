module Backend
  class DashboardController < BaseController

    def dashboard
      @users = User.all
    end
  end
end