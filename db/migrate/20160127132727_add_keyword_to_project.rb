class AddKeywordToProject < ActiveRecord::Migration
  def change
    add_column :projects, :keyword, :string
  end
end
