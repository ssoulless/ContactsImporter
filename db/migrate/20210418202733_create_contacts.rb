class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :date_of_birth
      t.string :phone
      t.string :address
      t.string :creditcard
      t.string :franchise
      t.string :email

      t.timestamps
    end
  end
end
