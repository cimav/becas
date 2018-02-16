class CreateScholarshipComments < ActiveRecord::Migration[5.1]
  def change
    create_table :scholarship_comments do |t|
      t.belongs_to :person, polymorphic: true
      t.string :content
      t.integer :status
      t.references :scholarship, foreign_key: true

      t.timestamps
    end
    add_index :scholarship_comments, [:person_id, :person_type]
  end
end
