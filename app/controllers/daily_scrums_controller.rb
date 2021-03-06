require 'date'

class DailyScrumsController < ApplicationController
  unloadable

  include Redmine::Export::PDF

  before_filter :get_project, :get_date
  before_filter :authorize

  def index
    get_daily_scrums
    get_post_scrum_actions

    respond_to do |format|
      format.html
      format.pdf  {
        pdf = daily_scrum_to_pdf(@project, @daily_scrums, @actions, @date)
        send_data(pdf, :type => 'application/pdf', :filename => "daily_scrum.pdf")
      }
    end
  end

  def edit
    get_daily_scrums(true)
    get_post_scrum_actions(true)
  end

  def update
    params[:daily_scrums].each do |scrum_params|
      user = User.find(scrum_params[0])
      if appears_in_scrum?(user)
        if user == User.current or allowed_to_see_all_scrums(User.current, true)
          scrum = get_daily_scrum(user)
          scrum.safe_attributes = scrum_params[1]
          scrum.save
        end
      end
    end
    if User.current.allowed_to?(:edit_daily_scrum, @project) and params[:post_scrum_actions]
      actions = get_post_scrum_actions(true)
      @actions.safe_attributes = params[:post_scrum_actions]
      actions.save
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
      @project.scrum_team_members.sorted.each do |m|
        user = m.user
        @daily_scrums << get_daily_scrum(user) if appears_in_scrum?(user)
      end
    elsif appears_in_scrum?(User.current)
      @daily_scrums << get_daily_scrum(User.current)
    end
  end

  def get_post_scrum_actions(edit = false)
    @actions = PostScrumAction.where(:project_id => @project.id, :date => @date)
    if @actions.any?
      @actions = @actions.first 
    else
      @actions = PostScrumAction.new(:project => @project, :date => @date)
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

  def appears_in_scrum?(user)
    @project.is_scrum_team_member?(user)
  end
end
