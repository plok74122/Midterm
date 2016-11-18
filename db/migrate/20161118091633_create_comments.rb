class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.text :comment_text
      t.integer :event_id

      t.timestamps
    end
  end
end
