Rails.application.routes.draw do
  mount Attachinary::Engine => "/attachinary"
  devise_for :users, :controllers => {sessions: 'sessions'}
  scope '(:locale)', locale: /fr/ do
    root to: 'pages#home'

    get "users/:id/profile", to: "profiles#show", as: "profile"
    patch "users/:id/profile", to: "profiles#update", as: "update_profile"
    get "users/:id/profile/edit", to: "profiles#edit", as: "edit_profile"
    post "user_competencies/search", to: "user_competencies#search", as: "search_user_competencies"

    resources :competencies, only: [:index, :new, :create, :destroy] do
      resources :badges, only: [:index]
    end

    resources :communities, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
      resources :memberships, only: [:new, :create, :index]
    end
    resources :memberships, only: [:edit, :update, :destroy]
    resources :user_competencies do
      resources :experiences, shallow: true
      resources :meetings, except: [:index], shallow: true
      resources :favorites, only: [:create, :destroy]
    end
    resources :meetings, only: [:index] do
      resources :reviews, :messages
    end
    resources :users, only: [] do
      resources :favorites, only: [:index]
    end
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
