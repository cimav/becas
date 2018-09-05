class AddNotesToScholarships < ActiveRecord::Migration[5.1]
  def change
    add_column :scholarships, :notes, :string
  end
end
