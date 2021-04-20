# frozen_string_literal: true

# Contacts creator service
class ContactCreator
  def self.create_contact(batch_id, batch_row, contact_attributes)
    new_contact = Contact.new(contact_attributes)
    new_contact.save
  rescue StandardError => e
    puts e
    batch_row.update_column(error_messages: e.inspect)
    batch_row.update_column(has_errors: true)
    batch = ContactsFile.find_by(id: batch_id)
    batch.update_column(has_errors: true)
  end
end
