class CreateTestimonials < ActiveRecord::Migration[5.0]
  def change
    create_table :testimonials do |t|
      t.text :body, null: false
      t.string :company, null: false
      t.string :first_name, null: false
      t.text :html_body, null: false
      t.string :last_name, null: false
      t.string :title, null: false
      t.integer :position, null: false, default: 0
      t.string :profile_picture, null: false
      t.boolean :published, default: false

      t.timestamps
    end
  end
end
