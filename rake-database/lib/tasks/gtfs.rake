require 'csv'
require 'json'

#
# Print a start load message in terminal when run :import_sptrans task
#
def startLoading(file)
    puts "=== start > reading #{file} - #{Time.now.strftime("%d/%m/%Y %H:%M:%S")} ==="
end

#
# Print a finish load message in terminal when run :import_sptrans task
#
def endLoading(file)
    puts "=== finish > reading #{file} - #{Time.now.strftime("%d/%m/%Y %H:%M:%S")} ==="
    puts " "
end

#
# Return header from a csv file
#
def getHeader(file_url)
    CSV.read(file_url, headers: true).headers #Read CSV header
end

#
# Load a CSV file and return a JSON with all the columns
#
def loadFileCSV(header, file_url)

    to_add = []

    CSV.foreach(file_url, headers: true) do |row|
        # Create a JSON object with the csv content, using the csv header to be a key for the values
        row_to_insert = row.to_hash.select { |k, v| header.include?(k) }

        # add each new json line in a array
        to_add << row_to_insert
    end

    return to_add
end

def containsPointValues?(path)
    ["sptrans/stops.txt", "sptrans/shapes.txt"].include? path
end

#
# Generate a SQL script based on content in CSV files
#

def generateSQLValue(path, header)

    frequencies = loadFileCSV(header, path)
    sqlValues = []

    # for each line in file
    frequencies.each do |v|
        str = []

        # find the value for the current column
        header.each do |m|
            # replace simple quote to double quote in string
            uniqueValue = "#{v["#{m}"]}".tr("'", '"')
            str.push("'#{uniqueValue}'")
        end

        sqlValues.push("("+str.join(',')+")")
    end

    sqlValues.join(',')
end

#
# Return the table name basead on file name
#

def getTableName(path)
    dir = "sptrans"
    case path
    when "#{dir}/frequencies.txt"
        return 'gtfs_engine_frequencies'
    when "#{dir}/agency.txt"
        return 'gtfs_engine_agencies'
    when "#{dir}/calendar.txt"
        return 'gtfs_engine_calendars'
    when "#{dir}/fare_attributes.txt"
        return 'gtfs_engine_fare_attributes'
    when "#{dir}/fare_rules.txt"
        return 'gtfs_engine_fare_rules'
    when "#{dir}/routes.txt"
        return 'gtfs_engine_routes'
    when "#{dir}/shapes.txt"
        return 'gtfs_engine_shapes'
    when "#{dir}/stops.txt"
        return 'gtfs_engine_stops'
    when "#{dir}/stop_times.txt"
        return 'gtfs_engine_stop_times'
    when "#{dir}/trips.txt"
        return 'gtfs_engine_trips'
    else
        return 1
    end
end

def execute(path)
    files = Dir["#{path}/*"]

    files.each do |file|
        startLoading(file)

        header = getHeader(file)

        sqlValues = generateSQLValue(file, header)
        sqlColumn = header.join(', ')
        tableName = getTableName(file)

        ActiveRecord::Base.connection.execute("INSERT INTO #{tableName} (#{sqlColumn}) VALUES #{sqlValues}")

        endLoading(file)
    end

    # Use inserted lat and long to generate a point object with WKT format
    puts "=== start > inserting lat/long point - #{Time.now.strftime("%d/%m/%Y %H:%M:%S")} ==="

    ActiveRecord::Base.connection.execute("UPDATE public.gtfs_engine_stops SET stop_point = ST_SetSRID(ST_MakePoint(stop_lon, stop_lat), 4326);")
    ActiveRecord::Base.connection.execute("UPDATE public.gtfs_engine_shapes SET shape_pt_point = ST_SetSRID(ST_MakePoint(shape_pt_lon, shape_pt_lat), 4326);")

    puts "=== finish > inserting lat/long point - #{Time.now.strftime("%d/%m/%Y %H:%M:%S")} ==="
    puts " "

end

def resetDB(env)
    Rails.env = env
    Rake::Task["db:drop"].invoke
    Rake::Task["db:create"].invoke
    Rake::Task["db:migrate"].invoke
end

namespace :gtfs do
    desc "Load GTFS data from CSV and insert into db"
    task :import => :environment do

        startExecution = Time.now

        resetDB("development")

        path = "sptrans"

        execute(path)

        finishExecution = Time.now

        diffTime = finishExecution - startExecution

        puts "==============================================="
        puts "This task took #{diffTime} seconds to execute."
        puts "=============================================== \n"
    end
end
