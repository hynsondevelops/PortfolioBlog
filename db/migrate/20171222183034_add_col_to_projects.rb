class AddColToProjects < ActiveRecord::Migration[5.0]
  def change
  	t.integer :author_id
  end
end
