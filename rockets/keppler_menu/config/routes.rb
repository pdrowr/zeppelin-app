KepplerMenu::Engine.routes.draw do
  namespace :admin do
    scope :menu, as: :menu do
      resources :dishes do
        post '/sort', action: :sort, on: :collection
        get '(page/:page)', action: :index, on: :collection, as: ''
        get '/clone', action: 'clone'
        post '/upload', action: 'upload', as: :upload
        get '/reload', action: :reload, on: :collection
        delete '/destroy_multiple', action: :destroy_multiple, on: :collection
      end

      get '/pictures/:picturable_id', to: 'pictures#pictures', as: :pictures
      patch '/pictures/:picturable_id/update', to: 'pictures#update', as: :update_pictures

      resources :categories do
        post '/sort', action: :sort, on: :collection
        get '(page/:page)', action: :index, on: :collection, as: ''
        get '/clone', action: 'clone'
        post '/upload', action: 'upload', as: :upload
        get '/reload', action: :reload, on: :collection
        get '/pictures', action: :pictures, on: :collection
        delete '/destroy_multiple', action: :destroy_multiple, on: :collection
      end

    end
  end
end
