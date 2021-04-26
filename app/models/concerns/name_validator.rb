# frozen_string_literal: true

# Validates the name of a Contact
class NameValidator < ActiveModel::Validator
  def validate(record)
    record.errors.add(:name, 'special characters not allowed') if record.name.match(/^[\-A-Za-z0-9 .&]*\z/).nil?
  end
end
