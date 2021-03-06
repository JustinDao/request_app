RequestApp::Application.routes.draw do
  devise_for :users, :controllers => {:registrations => "registrations"}

  match '/home', :to => "home#index"
  match '/browse', :to => "home#browse"
  match 'items/find', :to => "home#find"
  match 'search', :to => "items#search"
  match '/users/:user_id/items/:id/request', :to => "items#req", :as => "request_user_item"
  match 'my_requests', :to => 'requests#index'
  match 'my_items', :to => 'items#index'

  resources :users, :only => [] do
    resources :items do
      collection do
        post 'search'
      end
      member do
        post 'req'
      end
    end
    resources :requests, :only => [:index, :destroy] do
      get 'approve'
      get 'deny'
    end
  end

  authenticated :user do
    root :to =>  redirect("/home")
  end

  devise_scope :user do
    root :to => 'devise/sessions#new'
  end

  resources :item_types, :only => [:index, :show]

  resources :buildings, :only => [:index, :show]

  resources :residences, :only => [:index, :show]

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
