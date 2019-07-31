require_dependency "keppler_frontend/application_controller"

module KepplerFrontend
  class App::FrontendController < App::AppController
    before_action :set_index_variables, only: %i[index]
    before_action :authenticate_member, :set_period
    before_action :set_order, only: %i[categories dishes dishes account add_dish remove_dish send_to_kitchen toggle_dish_status cancel_order cancel_dish]
    before_action :set_account, only: %i[account create_order cancel_account billing]
    include FrontsHelper
    layout 'layouts/keppler_frontend/app/layouts/application'

    def index; end

    def manage_client
      @client = rocket('clients', 'client').set_client(client_params)

      if @client
        # if @client.have_active_account?(params[:table])
        #   notice = 'El cliente ya posee una cuenta abierta en ésta mesa'
        # else
          @client.create_account(params[:table], current_member.id, @period.id)
          notice = 'Cuenta Creada Exitosamente'
        # end
      end

      redirect_to root_path(section: params[:section], table: params[:table]), notice: notice
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
      @orders = rocket('orders', 'order').incompleted_drinks
    end

    def runner
      @completed_orders   = rocket('orders', 'order').completed_orders
      @incompleted_orders = rocket('orders', 'order').incompleted_orders
    end

    def account; end

    def add_dish
      @order.dishes.create(dish_params)
      redirect_back(fallback_location: root_path, notice: 'Plato añadido a la orden exitosamente')
    end

    def remove_dish
      item = @order.dishes.find(params[:item_id])
      item.destroy
      redirect_back(fallback_location: root_path, notice: 'Plato removido de la orden exitosamente')
    end

    def send_to_kitchen
      @order.send_to_kitchen
      redirect_back(fallback_location: root_path, notice: 'La orden ha sido enviada a cocina')
    end

    def toggle_dish_status
      dish = @order.dishes.find(params[:dish_id])
      dish.toggle_item
      redirect_back(fallback_location: root_path)
    end

    def cancel_order
      if valid_code?
        @order.cancel
        notice = 'La orden ha sido cancelada exitosamente'
      else
        notice = 'Código Inválido'
      end

      redirect_back(fallback_location: root_path, notice: notice)
    end

    def cancel_account
      if valid_code?
        @account.cancel
        notice = 'La cuenta ha sido cancelada exitosamente'
      else
        notice = 'Código Inválido'
      end

      redirect_back(fallback_location: root_path, notice: notice)
    end

    def cancel_dish
      if valid_code?
        dish = @order.dishes.find(params[:dish_id])
        dish.toggle!(:cancelled)
        notice = 'El plato ha sido cancelado exitosamente'
      else
        notice = 'Código Inválido'
      end

      redirect_back(fallback_location: root_path, notice: notice)
    end

    def get_client
      return if params[:identification].blank?
      identification = params[:identification]
      @client = rocket('clients', 'client').find_by_identification(identification)

      respond_to do |format|
        format.js { render json: @client, status: 202 }
      end
    end

    def create_order
      @account.orders.create(
        status: 'ACTIVE',
        period_id: @account.period_id
      )

      redirect_back(fallback_location: root_path, notice: 'Orden Creada Exitosamente')
    end

    def billing
      @account.close
      redirect_to root_path(notice: 'Orden Cerrada Exitosamente')
    end

    private

    def set_index_variables
      @sections = rocket('environments', 'section').order(position: :asc)
      @client   = rocket('clients', 'client').new
    end

    def client_params
      params.require(:client).permit(
        :name, :email, :identification, :address, :phone
      )
    end

    def dish_params
      params.require(:dish).permit(
        :order_id, :dish_id, :price, :quantity, :observation
      )
    end

    def set_order
      @order = rocket('orders', 'order').find_by_id(params[:order_id])
    end

    def set_account
      @account = rocket('orders', 'account').find_by_id(params[:account_id])
    end

    def set_period
      @period = rocket('periods', 'period').current_period
    end

    def valid_code?
      params[:code].eql?(@setting.manager_code)
    end
  end
end
