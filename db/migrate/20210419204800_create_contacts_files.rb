class CreateContactsFiles < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts_files do |t|
      t.string :file

      t.timestamps
    end
  end
end
