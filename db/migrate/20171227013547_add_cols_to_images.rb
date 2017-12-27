class AddColsToImages < ActiveRecord::Migration[5.0]
  def change
  	change_table :images do |t|
  		t.integer :post_id
  	end
  end
end
