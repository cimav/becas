class CreateUmaValues < ActiveRecord::Migration[5.1]
  def change
    create_table :uma_values do |t|
      t.float :value

      t.timestamps
    end
  end
end
