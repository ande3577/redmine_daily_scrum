# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html

get 'projects/:project_id/daily_scrum', :to => 'daily_scrums#index'
get 'projects/:project_id/daily_scrum/edit', :to => 'daily_scrums#edit'
put 'projects/:project_id/daily_scrum/update', :to => 'daily_scrums#update'
get 'projects/:project_id/scrum_team_members', :to => 'scrum_team_members#index'
post 'projects/:project_id/scrum_team_members/create', :to => 'scrum_team_members#create'
delete 'scrum_team_members/:id/destroy', :to => 'scrum_team_members#destroy'
put 'scrum_team_members/:id/update', :to => 'scrum_team_members#update'