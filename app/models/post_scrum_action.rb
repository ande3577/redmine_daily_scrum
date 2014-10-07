class PostScrumAction < ActiveRecord::Base
  include Redmine::SafeAttributes
  unloadable

  belongs_to :project
  validates_presence_of :project

  validates_presence_of :date
  validates_uniqueness_of :date, :scope => :project_id

  safe_attributes 'actions'

  def empty?
    return false if actions and actions.length() > 0
    true
  end
end
