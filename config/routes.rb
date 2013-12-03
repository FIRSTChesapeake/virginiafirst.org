VirginiaFIRST::Application.routes.draw do

  resource :account, controller: "accounts", only: [:show, :edit, :update, :destroy], path_names: {edit: "settings"}

  scope module: 'accounts', path: 'account' do
    resource :profile, controller: "profiles", path: "personal", only: [:edit, :create, :update], as: "personal_profile"
    resource :background, controller: "profiles", only: [:edit, :create, :update], as: "background_profile"
    resource :volunteer, controller: "profiles", only: [:show, :edit, :update], as: "volunteer_profile"
    resource :mentor, controller: "profiles", only: [:show, :edit, :update], as: "mentor_profile"
    resource :experience, controller: "profiles", only: [:edit, :update], as: "experience_profile"
    get 'events' => 'registrations#index', as: 'my_events'
    delete 'events/:id' => 'registrations#destroy', as: 'delete_my_event'
  end

  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks"}

  get 'home/events', as: 'upcoming_events'
  get 'home/faq', as: 'faq_home'
  get 'home/mentor', as: 'mentor_home'
  get 'home/volunteer', as: 'volunteer_home'

  get '/admin', to: redirect('/admin/events')
  scope module: 'admin', path: 'admin', as: 'admin' do
    scope path: '(/:program)' do
      resources :events
      resources :games
      scope module: 'volunteer', path: 'volunteer', as: 'volunteer' do
        resources :roles
      end
    end

    resources :skills
    resources :profiles, only: [:index, :show]
  end

  scope module: 'volunteer' do
    scope path: '(/:program)' do
      resource :registrations, path: 'register', as: 'volunteer_registration', only: [:new, :create, :show]
      resources :events, only: [:index, :show] do
        get 'profiles' => 'profiles#index'
        get 'reports/crew_break_down' => 'reports#crew_break_down', as: 'volunteer_break_down_report'
        get 'reports/shirts' => 'reports#shirts', as: 'volunteer_shirts_report'
        get 'email_blast' => 'email_blast#show', as: 'email_blast'
      end
    end
    resources :assignments
    get 'profiles/:id' => 'profiles#show', as: 'profile'
  end

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
  root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
