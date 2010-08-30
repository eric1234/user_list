ActionController::Routing::Routes.draw do |map|
  map.resources :users, :except => [:edit, :new]
end
