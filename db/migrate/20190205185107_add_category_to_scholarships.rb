class AddCategoryToScholarships < ActiveRecord::Migration[5.1]
  def change
    add_column :scholarships, :category, :integer
  end
end
