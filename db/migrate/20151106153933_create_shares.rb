class CreateShares < ActiveRecord::Migration
  def change
    create_table :shares do |t|
      t.references :user, index: true
      t.references :board, index: true

      t.timestamps null: false
    end
    add_foreign_key :shares, :users
    add_foreign_key :shares, :boards
  end
end
