class ScrumTeamMember < ActiveRecord::Base
  unloadable
  include Redmine::SafeAttributes

  acts_as_list :scope => :project
  scope :sorted, lambda { order("#{table_name}.position ASC") }
  
  belongs_to :project
  belongs_to :user

  safe_attributes 'move_to'
end
