Client::Application.routes.draw do

  root 'application#index'

  match '/:locale' => 'application#index', :via => :all
  match '/:locale/*route' => 'application#index', :via => :all

end
