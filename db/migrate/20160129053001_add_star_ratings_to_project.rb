class AddStarRatingsToProject < ActiveRecord::Migration
  def change
    add_column :projects, :rating1, :boolean, default: true
    add_column :projects, :rating2, :boolean, default: false
    add_column :projects, :rating3, :boolean, default: false
    add_column :projects, :rating4, :boolean, default: false
    add_column :projects, :rating5, :boolean, default: false
    add_column :projects, :views, :integer, default: 0
  end
end
