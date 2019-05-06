
# frozen_string_literal: true

require_dependency "keppler_staff/application_controller"
module KepplerStaff
  module Admin
    # ChefsController
    class ChefsController < ::Admin::AdminController
      layout 'keppler_staff/admin/layouts/application'
      before_action :set_chef, only: %i[show edit update destroy]
      before_action :index_variables
      include ObjectQuery

      # GET /staffs
      def index
        respond_to_formats(@chefs)
        redirect_to_index(@objects)
      end

      # GET /staffs/1
      def show; end

      # GET /staffs/new
      def new
        @chef = Chef.new
      end

      # GET /staffs/1/edit
      def edit; end

      # POST /staffs
      def create
        @chef = Chef.new(chef_params)

        if @chef.save
          redirect(@chef, params)
        else
          render :new
        end
      end

      # PATCH/PUT /staffs/1
      def update
        if @chef.update(chef_params)
          redirect(@chef, params)
        else
          render :edit
        end
      end

      def clone
        @chef = Chef.clone_record params[:chef_id]
        @chef.save
        redirect_to_index(@objects)
      end

      # DELETE /staffs/1
      def destroy
        @chef.destroy
        redirect_to_index(@objects)
      end

      def destroy_multiple
        Chef.destroy redefine_ids(params[:multiple_ids])
        redirect_to_index(@objects)
      end

      def upload
        Chef.upload(params[:file])
        redirect_to_index(@objects)
      end

      def reload; end

      def sort
        Chef.sorter(params[:row])
      end

      private

      def index_variables
        @q = Chef.ransack(params[:q])
        @chefs = @q.result(distinct: true)
        @objects = @chefs.page(@current_page).order(position: :asc)
        @total = @chefs.size
        @attributes = Chef.index_attributes
      end

      # Use callbacks to share common setup or constraints between actions.
      def set_chef
        @chef = Chef.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def chef_params
        params.require(:chef).permit(
          :avatar, :name, :username, :email, :code
        )
      end
    end
  end
end
