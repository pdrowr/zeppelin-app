
# frozen_string_literal: true

require_dependency "keppler_menu/application_controller"
module KepplerMenu
  module Admin
    # DishesController
    class DishesController < ::Admin::AdminController
      layout 'keppler_menu/admin/layouts/application'
      before_action :set_dish, only: %i[show edit update destroy]
      before_action :index_variables
      include ObjectQuery

      # GET /menus
      def index
        respond_to_formats(@dishes)
        redirect_to_index(@objects)
      end

      # GET /menus/1
      def show; end

      # GET /menus/new
      def new
        @dish = Dish.new
      end

      # GET /menus/1/edit
      def edit; end

      # POST /menus
      def create
        @dish = Dish.new(dish_params)

        if @dish.save
          redirect(@dish, params)
        else
          render :new
        end
      end

      # PATCH/PUT /menus/1
      def update
        if @dish.update(dish_params)
          redirect(@dish, params)
        else
          render :edit
        end
      end

      def clone
        @dish = Dish.clone_record params[:dish_id]
        @dish.save
        redirect_to_index(@objects)
      end

      # DELETE /menus/1
      def destroy
        @dish.destroy
        redirect_to_index(@objects)
      end

      def destroy_multiple
        Dish.destroy redefine_ids(params[:multiple_ids])
        redirect_to_index(@objects)
      end

      def upload
        Dish.upload(params[:file])
        redirect_to_index(@objects)
      end

      def reload; end

      def sort
        Dish.sorter(params[:row])
      end

      private

      def index_variables
        @q = Dish.ransack(params[:q])
        @dishes = @q.result(distinct: true)
        @objects = @dishes.page(@current_page)
        # .order(position: :asc)
        @total = @dishes.size
        @attributes = Dish.index_attributes
      end

      # Use callbacks to share common setup or constraints between actions.
      def set_dish
        @dish = Dish.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def dish_params
        params[:dish]
      end
    end
  end
end
