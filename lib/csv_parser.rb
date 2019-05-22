require 'csv'

# Parse CSV contents
class CsvParser
  attr_reader :file_content

  def initialize(file_content)
    @file_content = file_content
  end

  def render
    csv_object.each_with_object([]) do |row, arr|
      arr << row.to_hash.transform_keys(&:to_sym) unless row.to_hash.empty?
    end
  end

  private

  def csv_object
    CSV.parse(file_content, headers: true, skip_blanks: true, skip_lines: /^(?:,\s*)+$/)
  end
end
