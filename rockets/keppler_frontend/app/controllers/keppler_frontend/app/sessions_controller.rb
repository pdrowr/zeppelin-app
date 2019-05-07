require_dependency "keppler_frontend/application_controller"

module KepplerFrontend
  class App::SessionsController < App::AppController
    include FrontsHelper
    layout 'layouts/keppler_frontend/app/layouts/application'

    def new
    end

    def create
      member = KepplerStaff::Member.find_by(member_code: params[:member_code])
      member ? login_success(member) : login_error
    end

    def destroy
      session[:member_id] = nil
      redirect_to root_url, notice: "Logged out!"
    end

    private

    def login_success(member)
      session[:member_id] = member.id
      redirect_to root_url, notice: "Logged in!"
    end

    def login_error
      flash.now[:alert] = 'Invalid Code.'
      redirect_to frontend.app_new_session_path
    end
  end
end
