class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :user, index: true
      t.references :board, index: true
      t.text :contents
      t.references :comment, index: true

      t.timestamps null: false
    end
    add_foreign_key :comments, :users
    add_foreign_key :comments, :boards
    add_foreign_key :comments, :comments
  end
end
