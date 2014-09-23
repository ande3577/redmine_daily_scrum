require 'date'

class DailyScrumsController < ApplicationController
  unloadable

  before_filter :get_project, :get_date
  before_filter :authorize

  def index
    get_daily_scrums
  end

  def edit
    get_daily_scrums(true)
  end

  def update
    params[:daily_scrums].each do |scrum_params|
      user = User.find(scrum_params[0])
      scrum = get_daily_scrum(user)
      scrum.safe_attributes = scrum_params[1]
      scrum.save
    end
    redirect_to :action => :index, :project_id => @project.identifier, :date => @date
  end

  private
  def get_project
    @project = Project.find(params[:project_id])
  end

  def get_date
    if params[:date]
      @date = Date.parse params[:date]
    else
      @date = Date.today      
    end
  end

  def get_daily_scrums(edit = false)
    @daily_scrums = []
    if allowed_to_see_all_scrums(User.current, edit)
      @project.members.each do |m|
        @daily_scrums << get_daily_scrum(m.user)
      end
    elsif @project.users.include?(User.current)
      @daily_scrums << get_daily_scrum(User.current)
    end
  end

  def allowed_to_see_all_scrums(user, edit)
    return user.allowed_to?(:edit_daily_scrum, @project) if edit  
    user.allowed_to?(:view_daily_scrum, @project)
  end

  def get_daily_scrum(user)
    scrum = DailyScrum.where(:project_id => @project.id, :user_id => user.id, :date => @date)
    return scrum.first if scrum.any?
    DailyScrum.new(:project => @project, :user => user, :date => @date)
  end
end
