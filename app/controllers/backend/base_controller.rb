module Backend
  class BaseController < ApplicationController
    layout 'backend'
    include Restriction
    before_action :require_login
    before_action :check_for_access

    def not_authenticated
      redirect_to new_session_path
    end
  end
end