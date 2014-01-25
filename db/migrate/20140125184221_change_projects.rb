class ChangeProjects < ActiveRecord::Migration
  def change
    change_table :projects do |t|
      t.rename :created_by, :user_id
    end
  end
end
