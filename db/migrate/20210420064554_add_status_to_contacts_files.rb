class AddStatusToContactsFiles < ActiveRecord::Migration[6.1]
  def change
    add_column :contacts_files, :status, :string
    add_column :contacts_files, :row_size, :integer
  end
end
