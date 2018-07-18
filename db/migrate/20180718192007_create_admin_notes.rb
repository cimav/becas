class CreateAdminNotes < ActiveRecord::Migration[5.1]
  def change
    create_table :admin_notes do |t|
      t.references :user, foreign_key: true
      t.string :content
      t.integer :status
      t.references :scholarship, foreign_key: true

      t.timestamps
    end
  end
end
