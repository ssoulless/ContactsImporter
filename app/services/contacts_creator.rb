# frozen_string_literal: true

# Contacts creator service
class ContactCreator
  def self.create_contact(_batch_id, _batch_row, contact_attributes)
    new_contact = Contact.new(contact_attributes)
    new_contact.save
  rescue StandardError => e
    print e
  end
end
