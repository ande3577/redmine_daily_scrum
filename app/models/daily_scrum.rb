class DailyScrum < ActiveRecord::Base
  include Redmine::SafeAttributes
  unloadable

  belongs_to :user
  validates_presence_of :user

  belongs_to :project
  validates_presence_of :project

  validates_presence_of :date
  validates_uniqueness_of :date, :scope => [:user_id, :project_id]

  safe_attributes 'what_did_i_do_yesterday',
      'what_am_i_doing_today',
      'what_is_standing_in_my_way'
end
