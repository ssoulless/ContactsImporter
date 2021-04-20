class AddDefaultFalseToHasErrorsBooleanColumns < ActiveRecord::Migration[6.1]
  def change
    change_column_null :batch_rows, :has_errors, false
    change_column_null :contacts_files, :has_errors, false
  end
end
