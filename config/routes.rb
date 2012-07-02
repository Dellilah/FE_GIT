Projekt::Application.routes.draw do

 resources :comments do
    get 'addcomment_form', :on => :member
    post 'addcomment', :on => :member
    get 'remove', :on => :member
    get 'edit', :on => :member
    post 'update', :on => :member
  end
  
   resources :visibilities do
    get 'changevisibility_form', :on => :member
    post 'change_visibility', :on => :member
  end
  
  resources :tags do
    get 'addtags_form', :on => :member
    post 'addtags', :on => :member
  end
  
  resources :events do
     get 'events_same_time', :on =>:member
  	get 'subscribe', :on => :member
    get 'unsubscribe', :on => :member
    post 'search', :on => :member
    get 'admin_confirmation', :on => :member
    get 'admin_rollback_confirmation', :on => :member
  end
  
  resources :users do
	 get 'show_profile', :on => :member
   end
 

  resources :tags

  resources :categories

  resources :events

  resource :user_session, :only => [:new, :create, :destroy]
#  get "user_sessions/new"

 # get "user_sessions/create"

  #get "user_sessions/destroy"

  resources :users
  match 'recommended_events' => "events#recommended_events"
  match 'events/search' => "events#search"
  match 'events_same_time' => "events#events_same_time"
  match 'sign_up' => "users#new"
  match 'show_profile' => "users#show_profile"
  match 'edit_profile' => "users#edit"
  match 'login' =>  "user_sessions#new"
  match 'logout' => "user_sessions#destroy"
  match 'all_users' => "users#show"
  match 'remove_comment' => "comments#remove"
  
  # match 'users' => "users#show"

  root :to => "events#index"

#  get "users/new"

#  get "users/create"

#  get "users/edit"

#  get "users/update"

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
  # match ':controller(/:action(/:id(.:format)))'
end
