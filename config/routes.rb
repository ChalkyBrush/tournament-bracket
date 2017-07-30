Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  get '/competitions/:id' => 'competitions#view'
  post '/competitions/:id/addPlayer' => 'competitions#addPlayer'
  post '/competitions/:id/setScore' => 'competitions#setScore'
  get '/competitions/:id/getRound' => 'competitions#getRound'
  get '/heats' => 'heats#index'
end
