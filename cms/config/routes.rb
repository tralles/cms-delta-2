Delta2::Application.routes.draw do


  devise_for :users # , :path => "/", :path_names => { :sign_in => 'login', :sign_out => 'logout', :password => 'secret', :confirmation => 'verification', :unlock => 'unblock', :registration => 'register', :sign_up => 'join' }

  resources :users
  resources :constants
  resources :permissions
    
  
  


  resources :projects do
  
    resources :hosts
    resources :constants

    resources :documentables
    
    resources :documents do
      collection do 
        match 'search', :via => :all
      end
    end

    resources :branches do
      resources :branches do
      end  
      
      member do 
        post 'sort'
      end

      collection do 
        post 'nestedsort'
      end
    end

    resources :contents do
      resources :documents do

        member do 
          get 'assign'
          get 'remove'
        end
        
        collection do 
          post 'sort'
          match 'search', :via => :all
        end
      end
      
      resources :content_relation_types do
        resources :content_relations do 
          resources :contents
      
          collection do 
            post 'sort'
          end
        end
      end
    end

    resources :content_relation_types do
      
      collection do 
        post 'sort'
      end
    end

    resources :content_types do
      resources :content_element_types do
      end  

      resources :contents do
        resources :content_elements do
        end  
        
        member do
          get 'close'
        end
      end  

      member do 
        post 'sort'
      end
    end  

    member do
      match 'settings', :via => :all
      match 'users', :via => :all
    end
  end
    
  
  
  
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'application#dashboard'
  
  
  match '/upload/:project_id/:documentable_type/:documentable_id/create' => 'documents#create', :as => 'create_upload', :via => :all
  match '/upload/:project_id/:documentable_type/:documentable_id/uploaded' => 'documents#uploaded', :as => 'uploaded', :via => :all
  
  get 'logout' => 'users#logout', :as => 'logout'
  match 'search/:project_id/suggest' => 'application#search', :as => 'search_suggest', :via => :all





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
