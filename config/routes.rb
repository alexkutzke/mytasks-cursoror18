Rails.application.routes.draw do
  get 'welcome/index'

  resources :tasks do
		member do
			get 'toggle'
		end
	end

  resources :lists

	root "welcome#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
