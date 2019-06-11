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

    def table(index, section)
      render 'keppler_frontend/app/frontend/partials/table', index: index, section: section
    end

    def table_orders(sections)
      render 'keppler_frontend/app/frontend/partials/table_orders', sections: sections
    end

    def creaate_account_modal(section, table)
      render 'keppler_frontend/app/frontend/partials/create_account_modal', section: section, table: table
    end

    def add_dish_modal(dish, index, order)
      render 'keppler_frontend/app/frontend/partials/add_dish_modal', dish: dish, index: index, order: order
    end

    def orders(order)
      render 'keppler_frontend/app/frontend/partials/orders', order: order
    end

    def dish(dish, index)
      render 'keppler_frontend/app/frontend/partials/dish', dish: dish, index: index
    end

    def html_switch(order, dish, index)
      render 'keppler_frontend/app/frontend/partials/switch', order: order, dish: dish, index: index
    end

    def confirmation_modal(order, dish, index, type)
      render 'keppler_frontend/app/frontend/partials/confirmation_modal', order: order, dish: dish, index: index, type: type
    end
  end
end
