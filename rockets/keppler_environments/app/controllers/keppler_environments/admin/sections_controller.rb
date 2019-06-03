
# frozen_string_literal: true

require_dependency "keppler_environments/application_controller"
module KepplerEnvironments
  module Admin
    # SectionsController
    class SectionsController < ::Admin::AdminController
      layout 'keppler_environments/admin/layouts/application'
      before_action :set_section, only: %i[show edit update destroy]
      before_action :set_tables, only: %i[new create edit update]
      before_action :index_variables
      include ObjectQuery

      # GET /environments
      def index
        respond_to_formats(@sections)
        redirect_to_index(@objects)
      end

      # GET /environments/1
      def show; end

      # GET /environments/new
      def new
        @section = Section.new
      end

      # GET /environments/1/edit
      def edit; end

      # POST /environments
      def create
        @section = Section.new(section_params)

        if @section.save
          redirect(@section, params)
        else
          render :new
        end
      end

      # PATCH/PUT /environments/1
      def update
        if @section.update(section_params)
          redirect(@section, params)
        else
          render :edit
        end
      end

      def clone
        @section = Section.clone_record params[:section_id]
        @section.save
        redirect_to_index(@objects)
      end

      # DELETE /environments/1
      def destroy
        @section.destroy
        redirect_to_index(@objects)
      end

      def destroy_multiple
        Section.destroy redefine_ids(params[:multiple_ids])
        redirect_to_index(@objects)
      end

      def upload
        Section.upload(params[:file])
        redirect_to_index(@objects)
      end

      def reload; end

      def sort
        Section.sorter(params[:row])
      end

      private

      def index_variables
        @q = Section.ransack(params[:q])
        @sections = @q.result(distinct: true)
        @objects = @sections.page(@current_page).order(position: :asc)
        @total = @sections.size
        @attributes = Section.index_attributes
      end

      def set_tables
        @tables = KepplerEnvironments::Table.all.map(&:id_consumo)
        # @tables = KepplerEnvironments::Table.available_tables
      end

      # Use callbacks to share common setup or constraints between actions.
      def set_section
        @section = Section.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def section_params
        params.require(:section).permit(
          :name, :cover, :active, table_ids: []
        )
      end
    end
  end
end
