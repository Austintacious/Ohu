class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.integer :completion_status, default: 0, null: false
      t.text :success_status

      t.timestamps
    end
  end
end
