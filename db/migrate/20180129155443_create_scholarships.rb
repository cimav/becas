class CreateScholarships < ActiveRecord::Migration[5.1]
  def change
    create_table :scholarships do |t|
      t.belongs_to :person, polymorphic: true
      t.decimal :amount
      t.date :start_date
      t.date :end_date
      t.integer :scholarship_type
      t.integer :status

      t.timestamps
    end
    add_index :scholarships, [:person_id, :person_type]
  end
end
