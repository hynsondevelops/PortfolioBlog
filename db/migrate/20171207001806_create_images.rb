class CreateImages < ActiveRecord::Migration[5.0]
  def change
    create_table :images do |t|
    	t.string :img_file_name
	    t.string :img_content_type
	    t.integer :img_file_size
    	t.datetime :img_updated_at
		t.timestamps
    end
  end
end
