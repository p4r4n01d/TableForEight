TableForEight::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  root to: "home#index"
  get '/voting/:event_id/:vote_id', to: 'voting#index', as: :voting
  get '/api/places/:type', to: 'places#index'
  get '/result/:event_id', to: 'result#index'
  patch '/api/event/:event_id/:vote_id', to: 'votes#update', :defaults => { :format => 'json' }, as: :update_vote
  post '/email/:event_id', to: 'result#update', :defaults => { :format => 'json' } 
  get '/api/event/gettitle/:link', to: 'events#get_page_title', :defaults => { :format => 'json' }
  
 scope :api do
  resources :events, :defaults => { :format => 'json' }  do
    resources :votes, shallow: true, :defaults => { :format => 'json' }
  end  
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
