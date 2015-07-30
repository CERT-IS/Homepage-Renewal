class AddEssentialToUser < ActiveRecord::Migration
  def change
    add_column :users, :uid, :string, 			null: false, default: ""
    add_column :users, :realname, :string, 		null: false, default: ""
    add_column :users, :phone, :string, 		null: false, default: ""
    add_index  :users, :uid,             	    unique: true
    add_index  :users, :realname
  end
end
