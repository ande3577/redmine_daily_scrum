class ScrumTeamMembersController < ApplicationController
  unloadable
  before_filter :find_project, :except => [:destroy, :update]
  before_filter :find_member, :only => [:destroy, :update]
  before_filter :authorize

  include MembersHelper
  helper :members

  def index
  end

  def create
    members = []
    if params[:membership]
      if params[:membership][:user_ids]
        attrs = params[:membership].dup
        user_ids = attrs.delete(:user_ids)
        user_ids.each do |user_id|
          members << ScrumTeamMember.new(:user_id => user_id)
        end
      else
        members << ScrumTeamMember.new(:user_id => params[:membership][:user_id])
      end
      @project.scrum_team_members << members
    end

    respond_to do |format|
      format.html { redirect_to_index }
    end
  end

  def destroy
    @member.destroy
    respond_to do |format|
      format.html { redirect_to_index }
    end
  end

  def update
    @member.safe_attributes = params[:scrum_team_member]
    respond_to do |format|
      format.html { redirect_to_index }
    end
  end

  private
  def find_project
    @project = Project.find(params[:project_id])
  end

  def find_member
    @member = ScrumTeamMember.find(params[:id])
    @project = @member.project
  end

  def redirect_to_index
    redirect_to :action => :index, :project_id => @project.identifier
  end
end
