module KepplerFrontend
  # AppController -> Controller out the back-office
  class App::AppController < ::ApplicationController
    layout 'app/layouts/application'
    skip_before_action :verify_authenticity_token
    before_action :set_default_locale
    before_action :set_locale
    before_action :set_metas
    before_action :set_analytics
    helper_method :current_member

    include KepplerCapsules::Concerns::Lib

    def set_metas
      @theme_color = nil
      @meta = MetaTag.get_by_url(request.url)
      @social = @setting.social_account
      @meta_title = MetaTag.title(@post, @product, @setting)
      @meta_description = MetaTag.description(@post, @product, @setting)
      @meta_image = MetaTag.image(request, @post, @product, @setting)
      @meta_locale = @locale.eql?('es') ? 'es_VE' : 'en_US'
      @meta_locale_alternate = @locale.eql?('es') ? 'en_US' : 'es_VE'
      @country_code = @locale.eql?('es') ? 'VE' : 'US'
    end

    def current_member
      if session[:member_id]
        @current_user ||= KepplerStaff::Member.find(session[:member_id])
      else
        @current_user = nil
      end
    end

    private

    def authenticate_member
      return unless current_member.nil?
      redirect_to app_new_session_path
    end

    def capsule(model)
      model = model.singularize.downcase.camelize
      "KepplerCapsules::#{model}".constantize
    end

    def rocket(name, model)
      name = name.downcase.camelize
      model = model.singularize.downcase.camelize
      "Keppler#{name}::#{model}".constantize
    end

    def set_default_locale
      I18n.default_locale = KepplerLanguages::Language.where(active: true).first.try(:name)&.to_sym || :es
    end

    def set_locale
      if params[:locale]
        @locale = I18n.locale = params[:locale]
      elsif request.env['HTTP_ACCEPT_LANGUAGE']
        @locale = I18n.locale = I18n.default_locale
      end
    end

    def default_url_options(options = {})
      logger.debug "default_url_options is passed options: #{options.inspect}\n"
      { locale: I18n.locale }
    end

    def set_analytics
      @scripts = Script.select { |x| x.url == request.env['PATH_INFO'] }
    end

    def url_front
      "#{Rails.root}/rockets/keppler_frontend"
    end
  end
end
