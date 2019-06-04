
# frozen_string_literal: true

require_dependency "keppler_orders/application_controller"
module KepplerOrders
  module Admin
    # ItemsController
    class ItemsController < ::Admin::AdminController
      layout 'keppler_orders/admin/layouts/application'
      before_action :set_item, only: %i[show edit update destroy]
      before_action :index_variables
      include ObjectQuery

      # GET /orders
      def index
        respond_to_formats(@items)
        redirect_to_index(@objects)
      end

      # GET /orders/1
      def show; end

      # GET /orders/new
      def new
        @item = Item.new
      end

      # GET /orders/1/edit
      def edit; end

      # POST /orders
      def create
        @item = Item.new(item_params)

        if @item.save
          redirect(@item, params)
        else
          render :new
        end
      end

      # PATCH/PUT /orders/1
      def update
        if @item.update(item_params)
          redirect(@item, params)
        else
          render :edit
        end
      end

      def clone
        @item = Item.clone_record params[:item_id]
        @item.save
        redirect_to_index(@objects)
      end

      # DELETE /orders/1
      def destroy
        @item.destroy
        redirect_to_index(@objects)
      end

      def destroy_multiple
        Item.destroy redefine_ids(params[:multiple_ids])
        redirect_to_index(@objects)
      end

      def upload
        Item.upload(params[:file])
        redirect_to_index(@objects)
      end

      def reload; end

      def sort
        Item.sorter(params[:row])
      end

      private

      def index_variables
        @q = Item.ransack(params[:q])
        @items = @q.result(distinct: true)
        @objects = @items.page(@current_page).order(position: :asc)
        @total = @items.size
        @attributes = Item.index_attributes
      end

      # Use callbacks to share common setup or constraints between actions.
      def set_item
        @item = Item.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def item_params
        params.require(:item).permit(
          :order_id, :dish_id, :price, :quantity, :observation
        )
      end
    end
  end
end
