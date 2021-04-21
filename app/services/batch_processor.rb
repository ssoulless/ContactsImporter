# frozen_string_literal: true

# This service allows us to process the batch row by row
class BatchProcessor
  def self.call(batch)
    batch_rows = SmarterCSV.process(fetch_file(batch.file.url))
    batch.update_column(:row_size, batch_rows.size)

    batch_rows.each_with_index do |row, index|
      batch_row = BatchRow.new(row: index, status: 'Queued', contacts_file_id: batch.id, data: row)

      next unless batch_row.save

      CreateContactsWorker.perform_async(batch.id, batch_row.id)

      batch.update_column(:status, 'Processed') if index + 1 == batch.row_size
    end
  end

  def self.fetch_file(url)
    URI.parse(url).open
  end
end
