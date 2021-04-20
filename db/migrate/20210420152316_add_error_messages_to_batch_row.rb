class AddErrorMessagesToBatchRow < ActiveRecord::Migration[6.1]
  def change
    add_column :batch_rows, :error_messages, :string
    add_column :batch_rows, :has_errors, :boolean
  end
end
