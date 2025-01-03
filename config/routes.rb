Rails.application.routes.draw do
  get 'todos/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :listes do
    resources :todos do
      collection do
        delete 'destroy_many'
        patch 'important_many'
        patch 'unimportant_many'
      end
    end
  end

  resources :todos do
    # 添加集合路由：让 Rails 识别以下 /todos/... 路径上的请求，并映射到 Todos 控制器的相应动作上
    collection do
      delete 'destroy_many'
      patch 'important_many'
      patch 'unimportant_many'
    end
  end

  root "todos#index"

  # Defines the root path route ("/")
  # root "posts#index"
end
