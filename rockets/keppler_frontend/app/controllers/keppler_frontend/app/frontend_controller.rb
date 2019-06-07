require_dependency "keppler_frontend/application_controller"

module KepplerFrontend
  class App::FrontendController < App::AppController
    before_action :authenticate_member, :set_period
    before_action :set_order, only: %i[categories dishes account add_item remove_item send_to_kitchen toggle_dish_status]
    include FrontsHelper
    layout 'layouts/keppler_frontend/app/layouts/application'

    def index
      @sections   = KepplerEnvironments::Section.order(position: :asc)
      @categories = KepplerMenu::Category.all
      @dishes     = KepplerMenu::Dish.all
      @client     = KepplerClients::Client.new
    end

    def manage_client
      @client = KepplerClients::Client.where(email: params[:client][:email])
                                      .first_or_create(client_params)

      @client.create_order(params[:table], current_member.id, @period.id)
      redirect_to root_path(section: params[:section], table: params[:table])
    end

    def categories
      @categories = KepplerMenu::Category.all
    end

    def dishes
      @category = KepplerMenu::Category.find(params[:category_id])
      @dishes   = @category.dishes
      @item     = KepplerOrders::Item.new
    end

    def chef
      @orders = KepplerOrders::Order.incompleted_orders
    end

    def runner
      @completed_orders   = KepplerOrders::Order.completed_orders
      @incompleted_orders = KepplerOrders::Order.incompleted_orders
    end

    def account; end

    def add_item
      @order.dishes.create(dish_params)
      redirect_back(fallback_location: root_path)
    end

    def remove_item
      item = @order.dishes.find(params[:item_id])
      item.destroy
      redirect_back(fallback_location: root_path)
    end

    def send_to_kitchen
      @order.send_to_kitchen
      redirect_back(fallback_location: root_path)
    end

    def toggle_dish_status
      @dish = @order.dishes.find(params[:dish_id])
      @dish.toggle!(:completed)
      redirect_back(fallback_location: root_path)
    end

    private

    def client_params
      params.require(:client).permit(:name, :email, :identification, :address)
    end

    def dish_params
      params.require(:dish).permit(
        :order_id, :dish_id, :price, :quantity, :observation
      )
    end

    def set_order
      @order = KepplerOrders::Order.find_by_id(params[:order_id])
    end

    def set_period
      KepplerPeriods::Period.current_period
    end
  end
end
