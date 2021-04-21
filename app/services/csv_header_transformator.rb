# frozen_string_literal: true

# This service maps user mapping with CSV headers
class CsvHeaderTransformator
  def self.call(mapping_config)
    {
      keep_original_headers: true,
      key_mapping: mapping_config
    }
  end
end
