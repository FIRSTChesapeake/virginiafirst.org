Vafirst::Application.routes.draw do

  scope module: 'volunteer' do
    scope path: '(/:program)' do
      resource :registrations, path: 'register', as: 'registration', only: [:create, :show, :update] do
        member do
          get :confirm
          get :profile
        end
      end
    end
  end
  get '/:program/register/new', to: redirect('/%{program}/register')
  get '/register/new', to: redirect('/register')

  resource :account, controller: "accounts", only: [:show, :edit, :update, :destroy], path_names: {edit: "settings"}

  scope path: 'account' do
    resource :profile, controller: "accounts/profiles", path: "personal", only: [:edit, :create, :update]
    resource :background, controller: "accounts/profiles", only: [:edit, :create, :update], as: "background_profile"
    resource :volunteer, controller: "accounts/profiles", only: [:show, :edit, :update], as: "volunteer_profile"
    resource :experience, controller: "accounts/profiles", only: [:edit, :update], as: "experience_profile"
  end

  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks"}

  get "home/index", as: "home"

  get '/admin', to: redirect('/admin/events')
  scope module: 'admin', path: 'admin', as: 'admin' do
    scope path: '(/:program)' do
      resources :events
      resources :games
    end

    resources :skills

    scope module: 'volunteer', path: 'volunteer', as: 'volunteer' do
      resources :roles
    end
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
