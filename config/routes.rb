Rails.application.routes.draw do
  devise_for :users
  devise_for :admins
  root to: "home#index"
  
  authenticate :admin do
    resources :categories
    
    resources :products do
      resources :variations, only: [:index, :new, :create]
    end

    resources :variations, except: [:index, :new, :create, :show] do
      resources :properties, except: [:index, :show]
    end
    
    resources :coupons
  end

  resource :cart, only: [:show, :update] do
    member do
      post :pay_with_paypal
      get  :process_paypal_payment
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
