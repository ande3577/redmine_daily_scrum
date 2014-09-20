Redmine::Plugin.register :redmine_daily_scrum do
  name 'Redmine Daily Scrum plugin'
  author 'David S Anderson'
  description 'Plugin for recording daily scrum questions' 
  version '0.0.1'
  url 'http://github.com/ande3577/redmine_daily_scrum'
  author_url 'http://github.com/ande3577'

  project_module :daily_scrum do
    permission :view_daily_scrum, :daily_scrum => [:index, :show]
    permission :edit_daily_scrum, :daily_scrum => [:create, :new, :edit, :update]
    permission :view_own_daily_scrum, :daily_scrum => [:index, :show]
    permission :edit_own_daily_scrum, :daily_scrum => [:create, :new, :edit, :update]
  end
end
