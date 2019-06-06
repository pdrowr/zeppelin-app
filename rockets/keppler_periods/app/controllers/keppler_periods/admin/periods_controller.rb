
# frozen_string_literal: true

require_dependency "keppler_periods/application_controller"
module KepplerPeriods
  module Admin
    # PeriodsController
    class PeriodsController < ::Admin::AdminController
      layout 'keppler_periods/admin/layouts/application'
      before_action :set_period, only: %i[show edit update destroy toggle_status]
      before_action :index_variables
      include ObjectQuery

      # GET /periods
      def index
        respond_to_formats(@periods)
        redirect_to_index(@objects)
      end

      # GET /periods/1
      def show; end

      # GET /periods/new
      def new
        @period = Period.new
      end

      # GET /periods/1/edit
      def edit; end

      # POST /periods
      def create
        @period = Period.new(period_params)

        if @period.save
          redirect(@period, params)
        else
          render :new
        end
      end

      # PATCH/PUT /periods/1
      def update
        if @period.update(period_params)
          redirect(@period, params)
        else
          render :edit
        end
      end

      def clone
        @period = Period.clone_record params[:period_id]
        @period.save
        redirect_to_index(@objects)
      end

      # DELETE /periods/1
      def destroy
        @period.destroy
        redirect_to_index(@objects)
      end

      def destroy_multiple
        Period.destroy redefine_ids(params[:multiple_ids])
        redirect_to_index(@objects)
      end

      def upload
        Period.upload(params[:file])
        redirect_to_index(@objects)
      end

      def reload; end

      def sort
        Period.sorter(params[:row])
      end

      def toggle_status
        @period.toggle!(:open)
        redirect_to admin_periods_periods_path
      end

      private

      def index_variables
        @q = Period.ransack(params[:q])
        @periods = @q.result(distinct: true)
        @objects = @periods.page(@current_page).order(id: :desc)
        @total = @periods.size
        @attributes = Period.index_attributes
      end

      # Use callbacks to share common setup or constraints between actions.
      def set_period
        @period = Period.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def period_params
        params.require(:period).permit(
          :name, :date, :open
        )
      end
    end
  end
end
