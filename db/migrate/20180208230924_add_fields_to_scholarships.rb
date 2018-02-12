class AddFieldsToScholarships < ActiveRecord::Migration[5.1]
  def change
    add_column :scholarships, :project_number, :string
    add_column :scholarships, :request_number, :string
  end
end
