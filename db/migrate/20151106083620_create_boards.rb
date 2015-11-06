class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards do |t|
      t.string :title
      t.references :user, index: true
      t.text :contents, :limit => 4294967295

      t.timestamps null: false
    end
    add_foreign_key :boards, :users
  end
end
