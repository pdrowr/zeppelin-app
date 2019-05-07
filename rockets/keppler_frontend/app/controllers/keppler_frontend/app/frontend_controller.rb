require_dependency "keppler_frontend/application_controller"

module KepplerFrontend
  class App::FrontendController < App::AppController
    before_action :authenticate_member
    include FrontsHelper
    layout 'layouts/keppler_frontend/app/layouts/application'

    def index
    end
  end
end
