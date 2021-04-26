# frozen_string_literal: true

# Contacts model
class Contact < ApplicationRecord
  validates :name, presence: { message: 'Name is required' }
  validates_with NameValidator, if: :name_present?

  private

  def name_present?
    name.present?
  end
end
