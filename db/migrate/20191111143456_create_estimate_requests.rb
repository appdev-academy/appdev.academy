class CreateEstimateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :estimate_requests do |t|
      t.string :name, null: false
      t.string :company
      t.string :email, null: false
      t.string :subject, null: false
      t.date :deadline
      t.decimal :budget, precision: 15, scale: 2, null: false
      t.text :details, null: false
      t.boolean :is_ios, default: false
      t.boolean :is_android, default: false
      t.boolean :is_design, default: false
      t.boolean :is_backend_api, default: false
      t.boolean :is_admin_panel, default: false
      t.boolean :is_other, default: false
      t.string :document
      t.timestamps
    end
  end
end
