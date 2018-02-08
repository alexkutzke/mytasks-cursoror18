Rails.application.routes.draw do
  devise_for :users
  get 'welcome/index'

  resources :tasks, except: [:index, :show] do
		member do
			get 'toggle'
		end
	end

  resources :lists, except: [:index, :show] 

	root "welcome#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
