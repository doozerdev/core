Rails.application.routes.draw do

  root 'welcome#index'

  get 'items' => 'item#index', as: :items
  get 'items/new' => 'item#new', as: :new_item
  get 'items/:id' => 'item#show', as: :item
  post 'items' => 'item#create', as: :create_item
  delete 'items/:id' => 'item#destroy', as: :destroy_item
  post 'items/:id/toggle' => 'item#toggle', as: :toggle_item
  get 'items/:id/edit' => 'item#show', as: :edit_item
  patch 'items/:id/edit' => 'item#show', as: :save_item
  get 'items/:id/up' => 'item#move_up', as: :move_item_up
  get 'items/:id/down' => 'item#move_down', as: :move_item_down

  #Authentication Routes
  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

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
