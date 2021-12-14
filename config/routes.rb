Rails.application.routes.draw { resources :movies, only: %i[index create] }
