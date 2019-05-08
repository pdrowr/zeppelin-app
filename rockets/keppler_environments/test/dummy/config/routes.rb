Rails.application.routes.draw do
  mount KepplerEnvironments::Engine => "/keppler_environments"
end
