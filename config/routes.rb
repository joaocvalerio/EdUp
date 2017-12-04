Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    root :to => 'courses#index', as: :authenticated_root
    get 'track_clicks', to: 'courses#track_clicks'
    resources :courses, except: :index do
      get 'students', to: 'courses#course_students'
      resources :parts, except: :index
    end

    root :to => 'devise/sessions#new', as: :unauthenticated_root
  end

   namespace :api, defaults: { format: :json } do
    namespace :v1 do
      root:to => 'courses#index'
      get '/company_users', to: 'courses#company_users_index'
      resources :courses, except: [:index, :new, :edit] do
        resources :parts, except: [:index, :new, :edit]
        post '/add_students', to: 'students#add_students'
        get '/remove_student/:id', to: 'students#remove_student'
      end
    end
  end
end


