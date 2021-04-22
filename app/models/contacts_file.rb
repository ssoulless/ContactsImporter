# frozen_string_literal: true

# This model holds record of the uploaded files
class ContactsFile < ApplicationRecord
  attr_accessor :file

  has_many :batch_rows

  mount_uploader :file, FileUploader

  validates_with MappingValidator

  def enqueue_parsing
    puts '------- Callback Start -------'
    return if status == 'Processed'

    puts '------- Worker exec -------'
    BatchWorker.perform_async(id)
    # TODO: Track worker to know when it has finished.
  end
end
