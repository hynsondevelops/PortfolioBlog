class AddColToPost < ActiveRecord::Migration[5.0]
  def change
  	change_table :posts do |t|
    	t.boolean :draft
  	end
  end
end
