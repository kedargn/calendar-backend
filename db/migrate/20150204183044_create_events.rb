class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :status
      t.integer :cal_id
      t.datetime :start_time
      t.datetime :end_time
      t.string :recurrence
      t.integer :recurring_event_id
    end

    add_index :events, :cal_id
  end
end
