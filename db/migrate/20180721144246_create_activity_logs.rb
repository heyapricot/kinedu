class CreateActivityLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :activity_logs do |t|
      t.references :baby, foreign_key: true
      t.references :assistant, foreign_key: true
      t.references :activity, foreign_key: true
      t.datetime :start_time
      t.datetime :stop_time
      t.integer :duration
      t.string :comments

      t.timestamps
    end
  end
end
