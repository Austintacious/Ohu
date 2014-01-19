class AddAvatarToUsers < ActiveRecord::Migration
  def up
    add_attachment :users, :avatar
    add_attachment :projects, :avatar
    add_attachment :projects, :resource1
    add_attachment :projects, :resource2
    add_attachment :projects, :resource3
    add_attachment :projects, :resource4
    add_attachment :projects, :resource5
  end

  def down
    remove_attachment :users, :avatar
    remove_attachment :projects, :avatar
    remove_attachment :projects, :resource1
    remove_attachment :projects, :resource2
    remove_attachment :projects, :resource3
    remove_attachment :projects, :resource4
    remove_attachment :projects, :resource5
  end
end
