require_dependency "keppler_frontend/application_controller"

module KepplerFrontend
  class App::FrontendController < App::AppController
    before_action :authenticate_member
    include FrontsHelper
    layout 'layouts/keppler_frontend/app/layouts/application'

    def index
      @sections = KepplerEnvironments::Section.order(position: :asc)
      @categories = KepplerMenu::Category.all
      @dishes = KepplerMenu::Dish.all
      @client = KepplerClients::Client.new
    end

    def manage_client
      @client = KepplerClients::Client.where(email: params[:client][:email])
                                      .first_or_create(client_params)

      @client.create_order(params[:table], current_member.id)
      redirect_to root_path(section: params[:section], table: params[:table])
    end

    def categories
      @categories = KepplerMenu::Category.all
    end

    def dishes
      @category = KepplerMenu::Category.find(params[:category_id])
      @dishes = @category.dishes
    end

    def chef
      # @sections = KepplerEnvironments::Section.all
      @categories = KepplerMenu::Category.all
      @dishes = KepplerMenu::Dish.all
    end

    def runner
      @sections = KepplerEnvironments::Section.all
      @categories = KepplerMenu::Category.all
      @dishes = KepplerMenu::Dish.all
    end

    def account
      @sections = KepplerEnvironments::Section.all
      @categories = KepplerMenu::Category.all
      @dishes = KepplerMenu::Dish.all
    end

    private

    def client_params
      params.require(:client).permit(:name, :email, :identification, :address)
    end
  end
end
