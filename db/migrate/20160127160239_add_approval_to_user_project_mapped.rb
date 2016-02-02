class AddApprovalToUserProjectMapped < ActiveRecord::Migration
  def change
    add_column :user_project_mappeds, :approval, :boolean, default: false
  end
end
