class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.belongs_to :person, polymorphic: true
      t.string :message
      t.string :link
      t.integer :notification_type
      t.boolean :read

      t.timestamps
    end
    add_index :notifications, [:person_id, :person_type]
  end
end
