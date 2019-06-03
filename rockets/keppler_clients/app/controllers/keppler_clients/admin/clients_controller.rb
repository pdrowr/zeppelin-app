
# frozen_string_literal: true

require_dependency "keppler_clients/application_controller"
module KepplerClients
  module Admin
    # ClientsController
    class ClientsController < ::Admin::AdminController
      layout 'keppler_clients/admin/layouts/application'
      before_action :set_client, only: %i[show edit update destroy]
      before_action :index_variables
      include ObjectQuery

      # GET /clients
      def index
        respond_to_formats(@clients)
        redirect_to_index(@objects)
      end

      # GET /clients/1
      def show; end

      # GET /clients/new
      def new
        @client = Client.new
      end

      # GET /clients/1/edit
      def edit; end

      # POST /clients
      def create
        @client = Client.new(client_params)

        if @client.save
          redirect(@client, params)
        else
          render :new
        end
      end

      # PATCH/PUT /clients/1
      def update
        if @client.update(client_params)
          redirect(@client, params)
        else
          render :edit
        end
      end

      def clone
        @client = Client.clone_record params[:client_id]
        @client.save
        redirect_to_index(@objects)
      end

      # DELETE /clients/1
      def destroy
        @client.destroy
        redirect_to_index(@objects)
      end

      def destroy_multiple
        Client.destroy redefine_ids(params[:multiple_ids])
        redirect_to_index(@objects)
      end

      def upload
        Client.upload(params[:file])
        redirect_to_index(@objects)
      end

      def reload; end

      def sort
        Client.sorter(params[:row])
      end

      private

      def index_variables
        @q = Client.ransack(params[:q])
        @clients = @q.result(distinct: true)
        @objects = @clients.page(@current_page).order(position: :asc)
        @total = @clients.size
        @attributes = Client.index_attributes
      end

      # Use callbacks to share common setup or constraints between actions.
      def set_client
        @client = Client.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def client_params
        params.require(:client).permit(
          :name, :identification, :email, :address, :code
        )
      end
    end
  end
end
