# frozen_string_literal: true

# Create Contact Worker from the processed row
class CreateContactsWorker
  include Sidekiq::Worker

  sidekiq_options retry: true, queue: 'contacts', max_retries: 0

  def perform(batch_id, row_id)
    batch_row = BatchRow.find(row_id)

    batch_row.update_column(:status, 'Processing')

    contact_attributes = JSON.parse(batch_row.data)

    ContactCreator.create_contact(batch_id, batch_row, contact_attributes)

    batch_row.update_column(:status, 'Processed')
  end
end
