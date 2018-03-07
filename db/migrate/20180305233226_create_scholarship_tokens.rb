class CreateScholarshipTokens < ActiveRecord::Migration[5.1]
  def change
    create_table :scholarship_tokens do |t|
      t.references :scholarship, foreign_key: false
      t.string :token
      t.integer :status

      t.timestamps
    end
  end
end
