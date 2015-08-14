Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :companies, controllers: { registrations: 'registrations' }

  devise_scope :company do
    get 'companies/new/:type', to: 'companies#new', as: :company_sign_up
    get 'companies/type', to: 'companies#type_company', as: :company_type
    post 'companies/create', to: 'companies#create', as: :company_create
  end

  get 'companies', to: 'companies#index', as: :company_dashboard
  get 'projects', to: 'projects#index', as: :team_company_dashboard

  get 'company/cancel/:id', to: 'companies#cancel_account', as: :cancel_account

  get 'company/pay', to: 'charges#pay', as: :pay

  # get 'company/approve/:id', to: 'companies#approve_request', as: :approve_request
  # get 'company/reject/:id', to: 'companies#reject_request', as: :reject_request
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  root to: "home#index"
  resources :companies do
    collection do
      get '/approve/:id', to: 'companies#approve_request', as: :approve_request
      get '/reject/:id', to: 'companies#reject_request', as: :reject_request
    end
  end
  resources :charges
  resources :projects
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
