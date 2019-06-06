KepplerPeriods::Engine.routes.draw do
  namespace :admin do
    scope :periods, as: :periods do
      resources :periods do
        post '/sort', action: :sort, on: :collection
        get '(page/:page)', action: :index, on: :collection, as: ''
        get '/clone', action: 'clone'
        post '/upload', action: 'upload', as: :upload
        get '/reload', action: :reload, on: :collection
        delete '/destroy_multiple', action: :destroy_multiple, on: :collection
        post '/toggle/:id', action: :toggle_status, as: :toggle_period, on: :collection
      end

    end
  end
end
