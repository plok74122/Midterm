class AddUserToEvents < ActiveRecord::Migration[5.0]
  def change
  	add_column :events, :user_id, :integer
  	add_column :comments, :user_id, :integer
  end
end
