class DeletePercentToScholarships < ActiveRecord::Migration[5.1]
  def change
    remove_column :scholarships, :percent
  end
end
