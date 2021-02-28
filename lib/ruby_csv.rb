require 'csv'
require 'date'

module RubyCsv
  def self.parse
    format_data = format
    create_csv(format_data)
    report_txt(format_data)
  end

  # private

  # loops over array and makes a report.txt file
  def self.report_txt(array)
    txt = ''
    array.each do |hash|
      txt.concat("#{hash['first_name']} #{hash['last_name']} was born on #{hash['dob']} their effective_date is #{hash['effective_date']} call them at #{hash['phone_number']} and say hello\n")
    end
    File.open('data/report.txt', 'w+') { |f| f.write(txt) }
  end

  # takes array of hashes to write to csv
  def self.create_csv(array)
    path = 'data/output.csv'
    CSV.open(path, 'wb') do |csv|
      csv << array.first.keys
      array.each { |hash| csv << hash.values }
    end
  end

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
                  elsif %w[dob effective_date expiry_date].include?(key)
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
      return Date.strptime(date_string, '%m/%d/%Y').to_s if date_string.split('/').last.length == 4

      # other date format with '/' ex: '1/12/88'
      return Date.strptime(date_string, '%m/%d/%y').to_s
    end

    if date_string.include?('-')
      # check if the first string in the array has a length of 4 if so that is the year
      # ex : 1988-02-12 = ['1988', '02', '12']
      return Date.strptime(date_string, '%Y-%m-%d').to_s if date_string.split('-').first.length == 4

      # other date format with '-' ex: '1-11-88'
      Date.strptime(date_string, '%m-%d-%y').to_s
    end
  end

  private_class_method(
    :format,
    :report_txt,
    :create_csv,
    :date_format,
    :phone_number_format,
    :clean
  )
end
