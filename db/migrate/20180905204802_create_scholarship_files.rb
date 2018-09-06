class CreateScholarshipFiles < ActiveRecord::Migration[5.1]
  def change
    create_table :scholarship_files do |t|
      t.string :name
      t.string :file
      t.integer :file_type
      t.references :scholarship, foreign_key: true

      t.timestamps
    end
  end
end
