
# frozen_string_literal: true

require_dependency "keppler_menu/application_controller"
module KepplerMenu
  module Admin
    class PicturesController < ::Admin::AdminController
      layout 'keppler_menu/admin/layouts/application'
      before_action :set_object

      def pictures
        if @object.pictures.first.nil?
          @picture = KepplerMenu::Picture.new
        else
          @picture = @object.pictures.first
        end
      end

      def update
        if @object.pictures.first.nil?
          @object.pictures.create(picture: params[:picture][:picture])
        else
          @object.pictures.first.update(picture: params[:picture][:picture])
        end

        redirect_to "/admin/menu/#{@object.pictures.first.picturable_type.split('::').last.pluralize.downcase}"
      end

      private

      def picture_params
        params.require(:picture).permit(:picture)
      end

      def set_object
        object = params[:model].constantize
        @object = object.find(params[:picturable_id])
      end

    end
  end
end
