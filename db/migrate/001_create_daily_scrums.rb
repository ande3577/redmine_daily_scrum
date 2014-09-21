class CreateDailyScrums < ActiveRecord::Migration
  def change
    create_table :daily_scrums do |t|
      t.integer 'project_id'
      t.integer 'user_id'
      t.text 'what_did_i_do_yesterday'
      t.text 'what_am_i_doing_today'
      t.text 'what_is_standing_in_my_way'
      t.date 'date'
      t.datetime 'updated_at'
    end
  end
end
