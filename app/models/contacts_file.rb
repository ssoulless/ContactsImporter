# frozen_string_literal: true

# This model holds record of the uploaded files
class ContactsFile < ApplicationRecord
  attr_accessor :file

  has_many :batch_rows

  mount_uploader :file, FileUploader

  after_save :enqueue_parsing

  def enqueue_parsing
    BatchWorker.perform_async(id)
  end
end
