class CreateProjectImages < ActiveRecord::Migration[5.0]
  def change
    create_table :project_images do |t|
      t.integer :project_id
      t.string :image

      t.timestamps
    end
  end
end
