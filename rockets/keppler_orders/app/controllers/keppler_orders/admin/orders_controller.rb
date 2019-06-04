
# frozen_string_literal: true

require_dependency "keppler_orders/application_controller"
module KepplerOrders
  module Admin
    # OrdersController
    class OrdersController < ::Admin::AdminController
      layout 'keppler_orders/admin/layouts/application'
      before_action :set_order, only: %i[show edit update destroy]
      before_action :index_variables
      include ObjectQuery

      # GET /orders
      def index
        respond_to_formats(@orders)
        redirect_to_index(@objects)
      end

      # GET /orders/1
      def show; end

      # GET /orders/new
      def new
        @order = Order.new
      end

      # GET /orders/1/edit
      def edit; end

      # POST /orders
      def create
        @order = Order.new(order_params)

        if @order.save
          redirect(@order, params)
        else
          render :new
        end
      end

      # PATCH/PUT /orders/1
      def update
        if @order.update(order_params)
          redirect(@order, params)
        else
          render :edit
        end
      end

      def clone
        @order = Order.clone_record params[:order_id]
        @order.save
        redirect_to_index(@objects)
      end

      # DELETE /orders/1
      def destroy
        @order.destroy
        redirect_to_index(@objects)
      end

      def destroy_multiple
        Order.destroy redefine_ids(params[:multiple_ids])
        redirect_to_index(@objects)
      end

      def upload
        Order.upload(params[:file])
        redirect_to_index(@objects)
      end

      def reload; end

      def sort
        Order.sorter(params[:row])
      end

      private

      def index_variables
        @q = Order.ransack(params[:q])
        @orders = @q.result(distinct: true)
        @objects = @orders.page(@current_page).order(position: :asc)
        @total = @orders.size
        @attributes = Order.index_attributes
      end

      # Use callbacks to share common setup or constraints between actions.
      def set_order
        @order = Order.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def order_params
        params.require(:order).permit(
          :client_id, :waiter_id, :table_id, :status
        )
      end
    end
  end
end
