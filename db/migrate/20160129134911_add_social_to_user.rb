class AddSocialToUser < ActiveRecord::Migration
  def change
    add_column :users, :twitter, :string, default: ""
    add_column :users, :facebook, :string, default: ""
    add_column :users, :github, :string, default: ""
    add_column :users, :blog, :string, default: ""
  end
end
