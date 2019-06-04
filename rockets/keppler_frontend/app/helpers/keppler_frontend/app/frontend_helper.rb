module KepplerFrontend
  module App::FrontendHelper
    # begin devise_login
    def devise_login(hash = {})
      render 'keppler_frontend/app/partials/devise_login', params: params
    end
    # end devise_login

    def sidebar
      render 'keppler_frontend/app/frontend/partials/sidebar'
    end

    def top_bar(title)
      render 'keppler_frontend/app/frontend/partials/top_bar', title: title
    end

    def all_orders
      render 'keppler_frontend/app/frontend/partials/all_orders'
    end

    def table(index)
      render 'keppler_frontend/app/frontend/partials/table', index: index
    end

    def table_orders(sections)
      render 'keppler_frontend/app/frontend/partials/table_orders', sections: sections
    end

    def creaate_account_modal(section, table)
      render 'keppler_frontend/app/frontend/partials/create_account_modal', section: section, table: table
    end

    def add_item_modal(dish, index, order)
      render 'keppler_frontend/app/frontend/partials/add_item_modal', dish: dish, index: index, order: order
    end

  end
end
