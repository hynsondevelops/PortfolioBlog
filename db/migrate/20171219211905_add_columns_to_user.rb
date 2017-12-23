class AddColumnsToUser < ActiveRecord::Migration[5.0]
  def change
  	change_table :users do |t|
    	t.string :img_file_name
	    t.string :img_content_type
		t.integer :img_file_size
		t.datetime :img_updated_at
  	end
  end
end
