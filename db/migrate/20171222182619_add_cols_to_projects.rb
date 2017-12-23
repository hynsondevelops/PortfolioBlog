class AddColsToProjects < ActiveRecord::Migration[5.0]
  def change
  	change_table :projects do |t|
  		t.string :github
  		t.string :live_link
  		t.integer :author_id
  	end
  end
end
