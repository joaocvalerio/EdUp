Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
  authenticated :user do
      root :to => 'courses#index', as: :authenticated_root
      resources :courses, except: :index do
        resources :parts, except: :index
      end
    end
    unauthenticated :user do
      root :to => 'devise/sessions#new', as: :unauthenticated_root
    end
  end
end


