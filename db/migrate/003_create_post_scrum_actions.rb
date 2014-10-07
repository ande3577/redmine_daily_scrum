class CreatePostScrumActions < ActiveRecord::Migration
  def change
    create_table :post_scrum_actions do |t|
      t.integer 'project_id'
      t.text 'actions'
      t.date 'date'
      t.datetime 'updated_at'
    end
  end
end
