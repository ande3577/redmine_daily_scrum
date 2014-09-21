# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html

get 'projects/:project_id/daily_scrum', :to => 'daily_scrums#index'
get 'projects/:project_id/daily_scrum/edit', :to => 'daily_scrums#edit'
put 'projects/:project_id/daily_scrum/update', :to => 'daily_scrums#update'
