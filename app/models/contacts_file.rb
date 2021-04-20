# frozen_string_literal: true

# This model holds record of the uploaded files
class ContactsFile < ApplicationRecord
  attr_accessor :file

  mount_uploader :file, FileUploader
end