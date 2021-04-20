# frozen_string_literal: true

# This worker is the batch that contains the file that will be processed
class BatchWorker
  include Sidekiq::Worker

  sidekiq_options retry: true, queue: 'batches', max_retries: 5

  def perform(batch_id)
    batch = ContactsFile.find_by(id: batch_id)

    return unless batch

    batch.update_column(:status, 'Processing')
    BatchProcessor.call(batch)
  end
end
