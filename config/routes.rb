Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks", :registrations => "registrations" }
	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	get 'tags/:tag', to: 'snippets#index', as: :tag
	root to: 'snippets#index'
	resources :snippets do
		resources :reviews
	end
	match 'users/:id', :to => "user#index", :via => :get, as: 'user'
end
