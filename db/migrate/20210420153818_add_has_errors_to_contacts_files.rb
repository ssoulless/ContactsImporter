class AddHasErrorsToContactsFiles < ActiveRecord::Migration[6.1]
  def change
    add_column :contacts_files, :has_errors, :boolean
  end
end
