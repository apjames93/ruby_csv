require 'csv'
require 'date'

module RubyCsv
  def self.parse
    format_data = format
  end

  # private

  def self.format
    csv_array = CSV.parse(File.read('data/input.csv'), headers: true)
    csv_array.map { |data| clean(data) }
  end

  # loops over key values and formats key values
  def self.clean(data)
    hash = {}
    data.each do |key, v|
      # removes all white space
      value = v.nil? ? '' : v.gsub(/ /, '')

      hash[key] = if key == 'phone_number'
                    phone_number_format(value)
                  elsif ['dob', 'effective_date', 'expiry_date'].include?(key)
                      date_format(value)
                  else
                    value
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

    # parse date string to YYYY-MM-DD for the diff formats save in the csv
    def self.date_format(date_string)
      if date_string.include?('/')
         # check if the last string in the array has a length of 4 if so that is the year
         # ex : 1/7/1988 = ['1, '7', '1988']
         if date_string.split('/').last.length == 4
           return Date::strptime(date_string, '%m/%d/%Y').to_s
         end 
         # other date format with '/' ex: '1/12/88'
         return Date::strptime(date_string, '%m/%d/%y').to_s
      end

      if date_string.include?('-')
         # check if the first string in the array has a length of 4 if so that is the year
         # ex : 1988-02-12 = ['1988', '02', '12']
        if  date_string.split('-').first.length == 4
          return Date::strptime(date_string, '%Y-%m-%d').to_s
        end 
        # other date format with '-' ex: '1-11-88'
        return Date::strptime(date_string, '%m-%d-%y').to_s
      end
    end

  private_class_method(
    :format,
    :date_format,
    :phone_number_format,
    :clean
  )
end
