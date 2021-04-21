# frozen_string_literal: true

# Uploaded class for contacts files
class FileUploader < CarrierWave::Uploader::Base
  storage :fog

  after :store, :enqueue_parsing

  def enqueue_parsing(_file)
    model.enqueue_parsing
  end

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Add an allowlist of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_allowlist
    %w[csv txt]
  end
end
