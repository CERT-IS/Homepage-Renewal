class AddRealNameToBoardType < ActiveRecord::Migration
  def change
    add_column :board_types, :realname, :string
  end
end
