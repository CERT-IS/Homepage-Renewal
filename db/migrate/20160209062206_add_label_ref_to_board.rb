class AddLabelRefToBoard < ActiveRecord::Migration
  def change
    add_reference :boards, :label, index: true
    add_foreign_key :boards, :labels
    add_column :boards, :isopen, :boolean, default: true
  end
end
