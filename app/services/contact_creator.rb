# frozen_string_literal: false

# Contacts creator service
class ContactCreator
  def self.create_contact(batch_id, batch_row, contact_attributes)
    new_contact = Contact.new(contact_attributes)
    return if new_contact.save

    full_error_message = ''
    new_contact.errors.each do |error|
      full_error_message << "#{error.full_message} "
    end
    batch_row.update_column(:error_messages, full_error_message)
    batch_row.update_column(:has_errors, true)
    batch = ContactsFile.find_by(id: batch_id)
    batch.update_column(:has_errors, true)
  end
end
