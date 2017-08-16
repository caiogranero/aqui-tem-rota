Rails.application.routes.draw do
  resources :gtfs_engine_trips, only: [:index, :show]
  resources :gtfs_engine_stops, only: [:index, :show]
  resources :gtfs_engine_shapes, only: [:index, :show]
  resources :gtfs_engine_routes, only: [:index, :show]
  resources :gtfs_engine_frequencies, only: [:index, :show]
  resources :gtfs_engine_fare_rules, only: [:index, :show]
  resources :gtfs_engine_fare_attributes, only: [:index, :show]
  resources :gtfs_engine_calendars, only: [:index, :show]
  resources :gtfs_engine_stop_times, only: [:index, :show]
  resources :gtfs_engine_agencies, only: [:index, :show]

  get '*path' => redirect('/')

  # get '*unmatched_route', to: 'application#not_found'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
