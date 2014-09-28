class CreateScrumTeamMembers < ActiveRecord::Migration
  def change
    create_table :scrum_team_members do |t|
      t.integer :position
      t.integer :user_id
      t.integer :project_id
    end
  end
end
