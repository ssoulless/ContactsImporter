# frozen_string_literal: true

# Model to store row of a batch for background processing of imports
class BatchRow < ApplicationRecord
  serialize :data
  belongs_to :contacts_file
end
