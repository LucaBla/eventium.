class CreateEventJoinings < ActiveRecord::Migration[7.0]
  def change
    create_table :event_joinings do |t|
      t.string :title
      t.integer :joined_user_id
      t.integer :attended_event_id

      t.timestamps
    end
  end
end
