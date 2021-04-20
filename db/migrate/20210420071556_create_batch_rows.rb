class CreateBatchRows < ActiveRecord::Migration[6.1]
  def change
    create_table :batch_rows do |t|
      t.integer :row
      t.string :status
      t.integer :contacts_file_id
      t.string :data

      t.timestamps
    end
  end
end
