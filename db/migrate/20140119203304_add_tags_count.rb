class AddTagsCount < ActiveRecord::Migration
  def up
    add_column :projects, :tags_count, :integer, :default => 0

    Project.reset_column_information
    Project.all.each do |p|
      p.update_attribute :tags_count, p.tags.length
    end
  end

  def down
    remove_column :projects, :tags_count
  end
end
