class AddUmasToScholarshipTypes < ActiveRecord::Migration[5.1]
  def change
    add_column :scholarship_types, :in_umas, :boolean
    add_column :scholarship_types, :umas_max_amount, :float
    remove_column :scholarship_types, :category
  end
end
