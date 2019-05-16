
# frozen_string_literal: true

require_dependency "keppler_menu/application_controller"
module KepplerMenu
  module Admin
    # CategoriesController
    class CategoriesController < ::Admin::AdminController
      layout 'keppler_menu/admin/layouts/application'
      before_action :set_category, only: %i[show edit update destroy pictures]
      before_action :index_variables
      include ObjectQuery

      # GET /menus
      def index
        respond_to_formats(@categories)
        redirect_to_index(@objects)
      end

      # GET /menus/1
      def show; end

      # GET /menus/new
      def new
        @category = Category.new
      end

      # GET /menus/1/edit
      def edit; end

      # POST /menus
      def create
        @category = Category.new(category_params)

        if @category.save
          redirect(@category, params)
        else
          render :new
        end
      end

      # PATCH/PUT /menus/1
      def update
        if @category.update(category_params)
          redirect(@category, params)
        else
          render :edit
        end
      end

      def clone
        @category = Category.clone_record params[:category_id]
        @category.save
        redirect_to_index(@objects)
      end

      # DELETE /menus/1
      def destroy
        @category.destroy
        redirect_to_index(@objects)
      end

      def destroy_multiple
        Category.destroy redefine_ids(params[:multiple_ids])
        redirect_to_index(@objects)
      end

      def upload
        Category.upload(params[:file])
        redirect_to_index(@objects)
      end

      def reload; end

      def sort
        Category.sorter(params[:row])
      end

      private

      def index_variables
        @q = Category.ransack(params[:q])
        @categories = @q.result(distinct: true)
        @objects = @categories.page(@current_page)
        # .order(position: :asc)
        @total = @categories.size
        @attributes = Category.index_attributes
      end

      # Use callbacks to share common setup or constraints between actions.
      def set_category
        @category = Category.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def category_params
        params.require(:category).permit(
          :code, :name
        )
      end
    end
  end
end
