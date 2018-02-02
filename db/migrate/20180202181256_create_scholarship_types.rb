class CreateScholarshipTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :scholarship_types do |t|
      t.string :name
      t.string :description
      t.integer :category
      t.float :max_amount

      t.timestamps
    end
  end
end
