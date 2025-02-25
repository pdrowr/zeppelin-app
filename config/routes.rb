
Rails.application.routes.draw do
  localized do
    get '/index', to: 'app/front#index', as: :app_index
  end

  # root to: 'app/front#index'

  devise_for :users, skip: KepplerConfiguration.skip_module_devise

  post '/filter', to: 'admin/users#filter_by_role', as: :filter_by_role

  namespace :admin do
    root to: 'admin#root'

    namespace :rockets do
      get '/', action: :rockets
      post 'create/:rocket', action: :create, as: :create
      post 'install', action: :install
      post 'build/:rocket', action: :build, as: :build
      delete 'uninstall/:rocket', action: :uninstall, as: :uninstall
    end

    get '/seo/sitemap', to: 'seos#sitemap'
    get '/seo/robots', to: 'seos#robots'
    post '/seo/editor/save', to: 'seos#editor_save'

    resources :seos do
      post '/sort', action: :sort, on: :collection
      get '(page/:page)', action: :index, on: :collection, as: ''
      get '/clone', action: 'clone'
      post '/upload', action: 'upload', as: :upload
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

    resources :roles do
      get '(page/:page)', action: :index, on: :collection, as: ''
      get '/clone', action: 'clone'
      post '/upload', action: 'upload', as: :upload
      get '/download', action: 'download', as: :download
      post(
        '/sort',
        action: :sort,
        on: :collection,
      )
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
      # post '/show_description/:module/:action_name', action: 'show_description', as: :show_description
      # get(
      #   '/add_permissions',
      #   action: 'add_permissions',
      #   as: :add_permissions
      # )
      # post(
      #   '/create_permissions',
      #   action: 'create_permissions',
      #   as: :create_permissions
      # )
    end

    scope :roles do
      post(
        ':role_id/show_description/:module/:action_name',
        to: 'permissions#show',
        as: :role_show_description
      )
      get(
        ':role_id/add_permissions',
        to: 'permissions#add',
        as: :role_add_permissions
      )
      post(
        ':role_id/create_permissions',
        to: 'permissions#create',
        as: :role_create_permissions
      )
      post(
        ':role_id/toggle_permissions',
        to: 'permissions#toggle_permissions',
        as: :role_toggle_permissions
      )
    end

    resources :users do
      get '(page/:page)', action: :index, on: :collection, as: ''
      get '/delete_avatar', action: :delete_avatar
      get(
        '/reload',
        action: :reload,
        on: :collection
      )
      delete(
        '/destroy_multiple',
        action: :destroy_multiple,
        on: :collection,
        as: :destroy_multiple
      )
    end

    resources :meta_tags do
      get '(page/:page)', action: :index, on: :collection, as: ''
      get '/clone', action: 'clone'
      post '/upload', action: 'upload', as: :upload
      post(
        '/sort',
        action: :sort,
        on: :collection,
      )
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

    resources :scripts do
      get '(page/:page)', action: :index, on: :collection, as: ''
      get '/clone', action: 'clone'
      post '/upload', action: 'upload', as: :upload
      post(
        '/sort',
        action: :sort,
        on: :collection,
      )
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

    resources :settings, only: [] do
      collection do
        post '/lang/:locale', to: 'settings#change_locale', as: :change_locale
        get '/:config', to: 'settings#edit', as: ''
        put '/:config', to: 'settings#update', as: 'update'
        put '/manager_code', to: 'settings#manager_code', as: 'manager_code'
        put '/:config/appearance_default', to: 'settings#appearance_default', as: 'appearance_default'
      end
    end
  end

  scope ":admin_code" do
    devise_scope :user do
      get '/sign_in', to: 'devise/keppler_sessions#new'
      post '/sign_in', to: 'devise/keppler_sessions#create'
      delete '/sign_out', to: 'devise/keppler_sessions#destroy'
    end
  end

  # Errors routes
  match '/alert/403', to: 'errors#not_authorized', via: :all, as: :not_authorized
  match '/alert/404', to: 'errors#not_found', via: :all
  match '/alert/422', to: 'errors#unprocessable', via: :all
  match '/alert/500', to: 'errors#internal_server_error', via: :all

  # Dashboard routes engine
  mount KepplerGaDashboard::Engine, at: 'admin/dashboard', as: 'dashboard'

  # Frontend routes engine
  mount KepplerFrontend::Engine, at: '/', as: 'frontend'

  # Language routes engine
  mount KepplerLanguages::Engine, at: '/', as: 'languages'

  # Capsules routes engine
  mount KepplerCapsules::Engine, at: '/', as: 'capsules'

  # Ckeditor routes engine
  mount Ckeditor::Engine => '/ckeditor'

  # Periods routes engine
  mount KepplerPeriods::Engine, at: '/', as: 'periods'

  # Clients routes engine
  mount KepplerClients::Engine, at: '/', as: 'clients'

  # Orders routes engine
  mount KepplerOrders::Engine, at: '/', as: 'orders'

  # Menu routes engine
  mount KepplerMenu::Engine, at: '/', as: 'menu'

  # Environments routes engine
  mount KepplerEnvironments::Engine, at: '/', as: 'environments'

  # Staff routes engine
  mount KepplerStaff::Engine, at: '/', as: 'staff'
end
