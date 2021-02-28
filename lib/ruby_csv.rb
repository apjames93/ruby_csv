require 'csv'

module RubyCsv
  def self.parse
    format_data = format
  end

  # private

  def self.format
    csv_array = CSV.parse(File.read("csvs/input.csv"), headers: true)
    csv_array.map { |data| clean(data) }
  end

  # loops over key values and formats key values
  def self.clean(data)
    hash = {}
    data.each do |key, v|
    # removes all white space
    value = v.nil? ? '' : v.gsub(/ /, '')

      if key == 'phone_number'
          hash[key] = phone_number_format(value)
      else
          hash[key] = value
      end
    end
    hash
  end

  # formats number to E.164
  def self.phone_number_format(number)
    # removes all values that are not 0-9 and then take the last 10 characters from the string
    formatted_number = (number || '').tr('^0-9', '').split(//).last(10).join('').to_s
    formatted_number = '+1'.concat(formatted_number)
    formatted_number.length != 12 ? 'Invalid number' : formatted_number
  end

  private_class_method(
    :phone_number_format,
    :clean
  )

end
