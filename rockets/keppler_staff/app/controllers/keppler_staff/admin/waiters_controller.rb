
# frozen_string_literal: true

require_dependency "keppler_staff/application_controller"
module KepplerStaff
  module Admin
    # WaitersController
    class WaitersController < ::Admin::AdminController
      layout 'keppler_staff/admin/layouts/application'
      before_action :set_waiter, only: %i[show edit update destroy]
      before_action :index_variables
      include ObjectQuery

      # GET /staffs
      def index
        respond_to_formats(@waiters)
        redirect_to_index(@objects)
      end

      # GET /staffs/1
      def show; end

      # GET /staffs/new
      def new
        @waiter = Waiter.new
      end

      # GET /staffs/1/edit
      def edit; end

      # POST /staffs
      def create
        @waiter = Waiter.new(waiter_params)

        if @waiter.save
          redirect(@waiter, params)
        else
          render :new
        end
      end

      # PATCH/PUT /staffs/1
      def update
        if @waiter.update(waiter_params)
          redirect(@waiter, params)
        else
          render :edit
        end
      end

      def clone
        @waiter = Waiter.clone_record params[:waiter_id]
        @waiter.save
        redirect_to_index(@objects)
      end

      # DELETE /staffs/1
      def destroy
        @waiter.destroy
        redirect_to_index(@objects)
      end

      def destroy_multiple
        Waiter.destroy redefine_ids(params[:multiple_ids])
        redirect_to_index(@objects)
      end

      def upload
        Waiter.upload(params[:file])
        redirect_to_index(@objects)
      end

      def reload; end

      def sort
        Waiter.sorter(params[:row])
      end

      private

      def index_variables
        @q = Waiter.ransack(params[:q])
        @waiters = @q.result(distinct: true)
        @objects = @waiters.page(@current_page).order(position: :asc)
        @total = @waiters.size
        @attributes = Waiter.index_attributes
      end

      # Use callbacks to share common setup or constraints between actions.
      def set_waiter
        @waiter = Waiter.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def waiter_params
        params.require(:waiter).permit(
          :avatar, :name, :username, :email, :waiter_code
        )
      end
    end
  end
end
