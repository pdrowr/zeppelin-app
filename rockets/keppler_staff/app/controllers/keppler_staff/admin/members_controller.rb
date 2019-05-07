
# frozen_string_literal: true

require_dependency "keppler_staff/application_controller"
module KepplerStaff
  module Admin
    # MembersController
    class MembersController < ::Admin::AdminController
      layout 'keppler_staff/admin/layouts/application'
      before_action :set_member, only: %i[show edit update destroy]
      before_action :index_variables
      include ObjectQuery

      # GET /staffs
      def index
        respond_to_formats(@members)
        redirect_to_index(@objects)
      end

      # GET /staffs/1
      def show; end

      # GET /staffs/new
      def new
        @member = Member.new
      end

      # GET /staffs/1/edit
      def edit; end

      # POST /staffs
      def create
        @member = Member.new(member_params)

        if @member.save
          redirect(@member, params)
        else
          render :new
        end
      end

      # PATCH/PUT /staffs/1
      def update
        if @member.update(member_params)
          redirect(@member, params)
        else
          render :edit
        end
      end

      def clone
        @member = Member.clone_record params[:member_id]
        @member.save
        redirect_to_index(@objects)
      end

      # DELETE /staffs/1
      def destroy
        @member.destroy
        redirect_to_index(@objects)
      end

      def destroy_multiple
        Member.destroy redefine_ids(params[:multiple_ids])
        redirect_to_index(@objects)
      end

      def upload
        Member.upload(params[:file])
        redirect_to_index(@objects)
      end

      def reload; end

      def sort
        Member.sorter(params[:row])
      end

      private

      def index_variables
        @q = Member.ransack(params[:q])
        @members = @q.result(distinct: true)
        @objects = @members.page(@current_page).order(position: :asc)
        @total = @members.size
        @attributes = Member.index_attributes
      end

      # Use callbacks to share common setup or constraints between actions.
      def set_member
        @member = Member.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def member_params
        params.require(:member).permit(
          :picture, :name, :alias, :email, :member_code, :type
        )
      end
    end
  end
end
