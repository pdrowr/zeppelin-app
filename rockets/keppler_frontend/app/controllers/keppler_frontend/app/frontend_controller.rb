require_dependency "keppler_frontend/application_controller"

module KepplerFrontend
  class App::FrontendController < App::AppController
    before_action :authenticate_member
    include FrontsHelper
    layout 'layouts/keppler_frontend/app/layouts/application'

    def index
      @sections = KepplerEnvironments::Section.all
      @categories = KepplerMenu::Category.all
      @dishes = KepplerMenu::Dish.all
    end

    def categories
      @categories = KepplerMenu::Category.all
    end

    def dishes
      @category = KepplerMenu::Category.find(params[:category_id])
      @dishes = @category.dishes
    end
    def chef
      @sections = KepplerEnvironments::Section.all
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
  end
end
