module KepplerPeriods
  class ApplicationController < ::ApplicationController
    protect_from_forgery with: :exception
    before_action :user_signed_in?
    helper_method :current_member

    def current_member
      if session[:member_id]
        @current_user ||= KepplerStaff::Member.find(session[:member_id])
      else
        @current_user = nil
      end
    end

    def user_signed_in?
      return if current_user
      redirect_to main_app.new_user_session_path
    end
  end
end
