class ChangeProjectPermissions < ActiveRecord::Migration
  def up
    add_column :projects, :created_by, :integer, default: 1
  end

  def down
    remove_column :projects, :created_by
  end
end
