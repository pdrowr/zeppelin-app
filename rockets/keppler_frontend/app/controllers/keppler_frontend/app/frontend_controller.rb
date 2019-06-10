require_dependency "keppler_frontend/application_controller"

module KepplerFrontend
  class App::FrontendController < App::AppController
    before_action :set_index_variables, only: %i[index]
    before_action :authenticate_member, :set_period
    before_action :set_order, only: %i[categories dishes account add_dish remove_dish send_to_kitchen toggle_dish_status cancel_order cancel_dish]
    include FrontsHelper
    layout 'layouts/keppler_frontend/app/layouts/application'

    def index; end

    def manage_client
      @client = rocket('clients', 'client').set_client(client_params)
      @client.create_order(params[:table], current_member.id, @period.id)
      redirect_to root_path(section: params[:section], table: params[:table])
    end

    def categories
      @categories = rocket('menu', 'category').all.includes(:pictures, :dishes)
    end

    def dishes
      @category = rocket('menu', 'category').find(params[:category_id])
      @dishes   = @category.dishes.select(:codigo, :nombre, :precio1)
      @dish     = rocket('orders', 'item').new
    end

    def chef
      @orders = rocket('orders', 'order').incompleted_orders
    end

    def bar
      @orders = rocket('orders', 'order').incompleted_orders
    end

    def runner
      @completed_orders   = rocket('orders', 'order').completed_orders
      @incompleted_orders = rocket('orders', 'order').incompleted_orders
    end

    def account; end

    def add_dish
      @order.dishes.create(dish_params)
      redirect_back(fallback_location: root_path)
    end

    def remove_dish
      item = @order.dishes.find(params[:item_id])
      item.destroy
      redirect_back(fallback_location: root_path)
    end

    def send_to_kitchen
      @order.send_to_kitchen
      redirect_back(fallback_location: root_path)
    end

    def toggle_dish_status
      dish = @order.dishes.find(params[:dish_id])
      dish.toggle_item
      redirect_back(fallback_location: root_path)
    end

    def cancel_order
      return unless valid_code?

      @order.cancel
      redirect_back(fallback_location: root_path)
    end

    def cancel_dish
      return unless valid_code?
      dish = @order.dishes.find(params[:dish_id])
      dish.toggle!(:cancelled)
      redirect_back(fallback_location: root_path)
    end

    def get_client
      identification = params[:identification]
      @client = rocket('clients', 'client').find_by_identification(identification)

      respond_to do |format|
        format.js { render json: @client, status: 202 }
      end
    end

    private

    def set_index_variables
      @sections   = rocket('environments', 'section').order(position: :asc)
      @client     = rocket('clients', 'client').new
    end

    def client_params
      params.require(:client).permit(:name, :email, :identification, :address)
    end

    def dish_params
      params.require(:dish).permit(
        :order_id, :dish_id, :price, :quantity, :observation
      )
    end

    def set_order
      @order = rocket('orders', 'order').find_by_id(params[:order_id])
    end

    def set_period
      @period = rocket('periods', 'period').current_period
    end

    def valid_code?
      params[:code].eql?('12345')
    end
  end
end
