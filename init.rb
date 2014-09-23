require 'redmine_daily_scrum_project_patch'
require 'redmine_daily_scrum_user_patch'

Redmine::Plugin.register :redmine_daily_scrum do
  name 'Redmine Daily Scrum plugin'
  author 'David S Anderson'
  description 'Plugin for recording daily scrum questions' 
  version '0.0.1'
  url 'http://github.com/ande3577/redmine_daily_scrum'
  author_url 'http://github.com/ande3577'

  project_module :daily_scrum do
    permission :view_daily_scrum, :daily_scrums => [:index]
    permission :edit_daily_scrum, :daily_scrums => [:create, :new, :edit, :update]
    permission :view_own_daily_scrum, :daily_scrums => [:index]
    permission :edit_own_daily_scrum, :daily_scrums => [:create, :new, :edit, :update]

    menu :project_menu, :daily_scrums, { :controller => 'daily_scrums', :action => 'index' }, :caption => 'Daily Scrum', :after => :activity, :param => :project_id
  end
end
