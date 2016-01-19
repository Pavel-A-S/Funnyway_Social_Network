class CreateChats < ActiveRecord::Migration
  def change
    create_table :chats do |t|
      t.text :text
      t.integer :human_id

      t.timestamps null: false
    end
  end
end
