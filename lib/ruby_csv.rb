require 'csv'

module RubyCsv
  def self.parse
    csv_array = CSV.parse(File.read("data/input.csv"), headers: true)
    csv_array.map { |data| clean(data) }
    puts csv_array
  end

    # loops over key values and formats key values
    def self.clean(data)
      hash = {}
      data.each do |key, v|
        value =  v.nil? ? '' : v.strip
        hash[key] = value
      end
      hash
    end

end
