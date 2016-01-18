class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title, null: false
      t.datetime :start_day, null: false
      t.string :start_time
      t.datetime :end_day, null: false
      t.string :end_time
      t.boolean :start_allday, default: false
      t.boolean :end_allday, default: false
      t.string :location
      t.text :description

      t.timestamps null: false
    end
  end
end
