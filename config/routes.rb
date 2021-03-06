CoopSite::Application.routes.draw do

  # resources :swap_requests

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  root 'coops#index'

  get "/auth/google_login/callback" => "sessions#create"
  get "/signout" => "sessions#destroy", :as => :signout

  resources :coops do
    resources :meals do
      collection do
        get "edit_mult"
        put "update_mult"
      end
    end

    resources :shifts do
      collection do
        get "edit_mult"
        put "update_mult"
      end

      member do
        get "add_user"
        get "remove_user"
        get "add_user_pic/:pic", action: 'add_user_pic', as: 'add_user_pic'
      end

      resources :swap_requests do
        member do
          get "resolve"
        end
      end
    end

    member do
      get 'generate_member_join_link'
      get 'generate_admin_join_link'
      get 'member_join_link/:member_join_hash', action: 'member_join'
      get 'admin_join_link/:admin_join_hash', action: 'admin_join'
    end
  end

  resources :users do
    get 'edit_shifts'
  end

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
