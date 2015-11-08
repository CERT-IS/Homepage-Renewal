class AddTyperefToBoard < ActiveRecord::Migration
  def change
    add_reference :boards, :board_type, index: true
    add_foreign_key :boards, :board_types
    add_column :boards, :like_counts, :integer, default: 0
    add_column :boards, :share_counts, :integer, default: 0
  end
end
