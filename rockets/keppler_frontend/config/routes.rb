KepplerFrontend::Engine.routes.draw do
  root to: 'app/frontend#index'

  post '/sessions', to: 'app/sessions#create', as: :app_create_session
  get 'login', to: 'app/sessions#new', as: :app_new_session
  get 'logout', to: 'app/sessions#destroy', as: :app_destroy_session
  get '/categories(/:order_id)', to: 'app/frontend#categories', as: :app_categories
  get '/chef', to: 'app/frontend#chef', as: :app_chef
  get '/bar', to: 'app/frontend#bar', as: :app_bar
  get '/runner', to: 'app/frontend#runner', as: :app_runner
  get '/account/:account_id', to: 'app/frontend#account', as: :app_account
  get '/account/:account_id/create_order', to: 'app/frontend#create_order', as: :app_account_create_order
  get '/account/:account_id/billing', to: 'app/frontend#billing', as: :app_billing_account
  get '/category/:category_id/dishes(/:order_id)', to: 'app/frontend#dishes', as: :app_category_dishes
  post '/send_to_kitchen/:order_id', to: 'app/frontend#send_to_kitchen', as: :app_send_to_kitchen

  post '/client', to: 'app/frontend#manage_client', as: :app_manage_client
  post '/add_item/:order_id', to: 'app/frontend#add_dish', as: :app_add_dish
  post '/cancel_account/:account_id', to: 'app/frontend#cancel_account', as: :app_cancel_account
  post '/cancel_order/:order_id', to: 'app/frontend#cancel_order', as: :app_cancel_order
  post '/cancel_dish/:order_id/:dish_id', to: 'app/frontend#cancel_dish', as: :app_cancel_dish
  delete '/remove_item/:order_id/:item_id', to: 'app/frontend#remove_dish', as: :app_remove_dish
  post '/toggle_dish_status/:order_id/:dish_id', to: 'app/frontend#toggle_dish_status', as: :app_toggle_dish_status

  post '/get_client', to: 'app/frontend#get_client'

  namespace :admin do
    scope :frontend, as: :frontend do
      resources :themes do
        get '(page/:page)', action: :index, on: :collection, as: ''
        get '/clone', action: 'clone'
        post '/sort', action: :sort, on: :collection
        post '/upload', action: 'upload', as: 'upload'
        get '/download', action: 'download', as: 'download'
        get '/show_covers', action: 'show_covers', as: 'show_covers'
        get(
          '/reload',
          action: :reload,
          on: :collection,
        )
        delete(
          '/destroy_multiple',
          action: :destroy_multiple,
          on: :collection,
          as: :destroy_multiple
        )
      end

      get '/views', to: 'views#index', as: 'views'
      post '/views/select_theme', to: 'views#select_theme', as: 'views_select_theme'
      get '/views/refresh', to: 'views#refresh', as: 'views_refresh'
      post '/views/generate', to: 'views#generate', as: 'views_generate'
      delete '/views/remove/:file', to: 'views#remove', as: 'views_remove'

      get '/assets', to: 'multimedia#index', as: 'multimedia'
      post '/assets/upload', to: 'multimedia#upload', as: 'upload_multimedia'
      get '/assets/upload', to: 'multimedia#upload', as: 'show_upload_multimedia'
      delete '/assets/:search/:fileformat', to: 'multimedia#destroy', as: 'destroy_multimedia'
      get '/assets/:search/:fileformat', to: 'multimedia#destroy', as: 'show_destroy_multimedia'

    end
  end
end
