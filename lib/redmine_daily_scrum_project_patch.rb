module RedmineDailyScrumProjectPatch
  def self.included(base)
    unloadable
    
    base.extend(ClassMethods)
    base.send(:include, InstanceMethods)
    base.class_eval do
      has_many :daily_scrums, :dependent => :destroy
      has_many :scrum_team_members, :dependent => :destroy
    end
  end
  
  module ClassMethods
  end
  
  module InstanceMethods
    def available_scrum_members
      self.users.sort.select{ |u| available_for_scrum_team_member?(u) }
    end

    def is_scrum_team_member?(user)
      self.scrum_team_members.pluck(:user_id).include?(user.id)
    end

    private
    def available_for_scrum_team_member?(user)
      user and !is_scrum_team_member?(user)
    end
  end
  
end

Project.send(:include, RedmineDailyScrumProjectPatch)
