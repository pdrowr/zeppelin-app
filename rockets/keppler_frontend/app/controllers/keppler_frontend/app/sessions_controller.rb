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
      redirect_to frontend.app_new_session_path, notice: "Logged out!"
    end

    private

    def login_success(member)
      session[:member_id] = member.id
      redirect_to handle_route_redirection, notice: "Logged in!"
    end

    def login_error
      flash.now[:alert] = 'Invalid Code.'
      redirect_to frontend.app_new_session_path
    end

    def handle_route_redirection
      case current_member.member_type
      when 'chef'
        app_chef_path
      when 'runner'
        app_runner_path
      when 'bartender'
        app_bar_path
      when 'waiter'
        root_path
      end
    end
  end
end
