class CreateSessions < ActiveRecord::Migration[5.0]
  def change
    create_table :sessions do |t|
      t.string :access_token, null: false
      t.integer :user_id, null: false, index: true
      t.timestamps
    end
  end
end