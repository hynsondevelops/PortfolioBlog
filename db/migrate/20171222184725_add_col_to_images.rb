class AddColToImages < ActiveRecord::Migration[5.0]
  def change
  	change_table :images do |t|
  		t.integer :project_id
  	end
  end
end
