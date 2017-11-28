Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
      root :to => 'courses#index', as: :authenticated_root
      resources :courses, except: :index do
        resources :parts, except: :index
      end

      root :to => 'devise/sessions#new', as: :unauthenticated_root
  end
end


