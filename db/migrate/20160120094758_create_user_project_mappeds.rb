class CreateUserProjectMappeds < ActiveRecord::Migration
  def change
    create_table :user_project_mappeds do |t|
      t.references :user, index: true
      t.references :project, index: true
      t.boolean :master, default: false

      t.timestamps null: false
    end
    add_foreign_key :user_project_mappeds, :users
    add_foreign_key :user_project_mappeds, :projects
  end
end
