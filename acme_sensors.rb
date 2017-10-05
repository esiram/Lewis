#!/usr/bin/ruby
# Program name: acme_sensors.rb

require "optparse"
require "csv"

def sensor_grade_inventory(csv)
  # Quantifies inventory by sensor grade and type

  doc_name = "= " + @file_name + "\n"

  thermo_pro = 0
  thermo_prosumer = 0
  thermo_discount = 0
  hygro_pro = 0
  hygro_prosumer = 0
  hygro_discount = 0

  contents = CSV.open csv, headers: true, header_converters: :symbol

  contents.each do |row|
    m = Meter.new(row[:type], row[:test_date], row[:date_built], row[:expected_value], row[:measured_value])
    if m.type == "thermometer"
      if m.thermometer_grade(self) == "pro-grade"
        thermo_pro = thermo_pro + 1
      elsif m.thermometer_grade(self) == "prosumer-grade"
        thermo_prosumer = thermo_prosumer + 1
      else
        thermo_discount = thermo_discount + 1
      end
    else m.type == "hygrometer"
      if m.hygrometer_grade(self) == "pro-grade"
        hygro_pro = hygro_pro + 1
      elsif m.hygrometer_grade(self) == "prosumer-grade"
        hygro_prosumer = hygro_prosumer + 1
      else
        hygro_discount = hygro_discount + 1
      end
    end
  end

  # Prints graded inventory results with messages for humans
  total_thermometers = thermo_pro + thermo_prosumer + thermo_discount
  if total_thermometers == 0
    message_therm = "No Thermometers\n"
  else
    message_therm = "Thermometers:\n" + "  " + thermo_pro.to_s + " Pro\n" + "  " + thermo_prosumer.to_s + " Prosumer\n" + "  " + thermo_discount.to_s + " Discount\n"
  end
  total_hygrometers = hygro_pro + hygro_prosumer + hygro_discount
  if total_hygrometers == 0
    message_hygro = "No Hygrometers\n"
  else
    message_hygro = "Hygrometers:\n" + "  " + hygro_pro.to_s + " Pro\n" + "  " + hygro_prosumer.to_s + " Prosumer\n" + "  " + hygro_discount.to_s + " Discount\n"
  end
  puts doc_name + message_therm + message_hygro

end


class Meter

  # Creates meter object and sets its attributes
  def initialize(type,test_date, date_built, expected_value, measured_value)
    @type = type
    @test_date = test_date
    @date_built = date_built
    @expected_value = expected_value.to_f
    @measured_value = measured_value.to_f
  end

  def type
    @type
  end

  def test_date
    @test_date
  end

  def date_built
    @date_built
  end

  def expected_value
    @expected_value
  end

  def measured_value
    @measured_value
  end

  # Determines meter grades
  def thermometer_grade(thermometer)
    grade = @expected_value - @measured_value
    if grade <= 1.5 && grade >= -1.5
      result = "pro-grade"
    elsif grade <= 10 && grade >= -10
      result = "prosumer-grade"
    else
      result = "discount"
    end
    return result
  end

  def hygrometer_grade(hygrometer)
    grade = @expected_value - @measured_value
    if grade <= 4 && grade >= -4
      result = "pro-grade"
    elsif grade <= 15 && grade >= -15
      result = "prosumer-grade"
    else
      result = "discount"
    end
    return result
  end

end


# Options parser for accessing csv files on command line
options = {}

OptionParser.new do |opts|
  opts.on("-d", "--directory [PATH]", "Path to CSV file directory") do |path|
    options[:csvDirectoryPath] = path
  end
end.parse!

csv_directory = options[:csvDirectoryPath]
valid_directory = csv_directory && File.exist?(csv_directory) && File.readable?(csv_directory) && File.directory?(csv_directory)

if valid_directory
  Dir.foreach(csv_directory) do |file|
    if File.extname(file) == ".csv"
      @file_name = file.to_s
      sensor_grade_inventory(File.realdirpath(file, csv_directory))
    end
  end
else
  if !csv_directory
    puts "Please supply CSV directory name."
  else
    if !File.exists?(csv_directory)
      puts "This directory does not exist."
    else
      if !File.readable?(csv_directory)
        puts "This directory is not readable."
      else
        if !File.directory?(csv_directory)
          puts "The path is not a directory."
        else
          puts "Unknown error."
        end
      end
    end
  end
end
