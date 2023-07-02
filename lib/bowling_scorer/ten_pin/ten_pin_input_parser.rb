module TenPinInputParser
  def read_input_file(file_path)
    input_data = read_lines(file_path)
    raise ArgumentError, 'Error: empty input file' if input_data.empty?

    input_data
  end

  def read_lines(file_path)
    input_data = Hash.new { |hash, key| hash[key] = [] }
    File.foreach(file_path) do |line|
      values = line.chomp.strip.split("\t")
      if values.size != 2
        puts "Error: invalid input format: '#{values.join("\t")}'"
        exit 1
      end
      input_data[values[0]] << values[1]
    end

    input_data
  end
end
