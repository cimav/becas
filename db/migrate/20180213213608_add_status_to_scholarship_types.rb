class AddStatusToScholarshipTypes < ActiveRecord::Migration[5.1]
  def change
    add_column :scholarship_types, :status, :integer
  end
end
