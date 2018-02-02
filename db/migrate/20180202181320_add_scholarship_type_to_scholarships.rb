class AddScholarshipTypeToScholarships < ActiveRecord::Migration[5.1]
  def change
    add_reference :scholarships, :scholarship_type, foreign_key: true
    add_column :scholarships, :max_amount, :float
    add_column :scholarships, :percent, :float
  end
end
