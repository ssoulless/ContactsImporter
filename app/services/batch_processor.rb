# frozen_string_literal: true

# This service allows us to process the batch row by row
class BatchProcessor
  def self.call(batch)
    batch_rows = SmarterCSV.process(batch.file.url)

    batch.update_column(:rows_size, batch_rows.size)

    batch_rows.each_with_index do |row, index|
      batch_row = BatchRow.new(row: index, status: 'Queued', batch_id: batch.id, data: row)

      next unless batch_row.save

      CreateContactsWorker.perform_async(batch.id, batch_row.id)
    end
  end
end
