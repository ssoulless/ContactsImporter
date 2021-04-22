# frozen_string_literal: true

# Validates the mapping of CSV files
class MappingValidator < ActiveModel::Validator
  def validate(record)
    mapping_config = JSON.parse(record.mapping_config)
    repeated_values = mapping_config.group_by { |_k, v| v }.select { |_k, v| v.count > 1 }
    record.errors.add(:mapping, 'duplicated mapping') unless repeated_values.empty?
  end
end
