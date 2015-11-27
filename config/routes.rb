Rails.application.routes.draw do

  # GENERAL ROUTES
  root 'base#index'

  devise_for :users
  resources :users, only: [:show, :update] do
    member do
      patch 'update_avatar'
      put 'update_avatar'
      post 'like'
      delete 'unlike'
    end

    resources :profile, only: [:index]
  end

  resources :boards, only: [] do
    resources :comments, only: [:create, :edit, :destroy, :update]
  end
  resources :notices, controller: 'board_notice'
  resources :frees, controller: 'board_free'
  resources :reviews, controller: 'board_review'
  resources :genealogies, controller: 'board_genealogy'
  resources :galleries, controller: 'board_gallery'

  get '/privacy_policy' => 'base#privacy'
  get '/terms_service' => 'base#terms'
  get '/contact' => 'base#contact'
  get '/members' => 'users#index'


  # ADMIN ROUTES
  get '/admin/membership'
  patch '/admin/membership' => 'admin#membership_update'
  put '/admin/membership' => 'admin#membership_update'
  
  # API ROUTES
  namespace :api, path: '/', constraints: { subdomain: 'api' } do
    namespace :v1 do
      get '/authenticate' => 'auth#get_token'
      resources :notices, controller: 'board_notice'
    end
  end

  # , constraints: { subdomain: 'api' }

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
