# frozen_string_literal: true

module App
  # AppController -> Controller out the back-office
  class AppController < ::ApplicationController
    layout 'app/layouts/application'
    skip_before_action :verify_authenticity_token
    before_action :set_metas
    before_action :set_analytics

    def set_metas
      @theme_color = nil
      @setting = Setting.first
      @meta = MetaTag.get_by_url(request.url)
      @social = SocialAccount.last
      @meta_title = MetaTag.title(@post, @product, @setting)
      @meta_description = MetaTag.description(@post, @product, @setting)
      @meta_image = MetaTag.image(request, @post, @product, @setting)
      @meta_locale = @locale.eql?('es') ? 'es_VE' : 'en_US'
      @meta_locale_alternate = @locale.eql?('es') ? 'en_US' : 'es_VE'
      @country_code = @locale.eql?('es') ? 'VE' : 'US'
    end

    private

    def default_url_options(options = {})
      logger.debug "default_url_options is passed options: #{options.inspect}\n"
      { locale: I18n.locale }
    end

    def set_analytics
      @scripts = Script.select { |x| x.url == request.env['PATH_INFO'] }
    end
  end
end
