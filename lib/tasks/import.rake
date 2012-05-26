require 'csv'

namespace :import do
  task :locations => :environment do
    source = ENV['SOURCE']
    if source.present?
      CSV.foreach(source) do |row|
        column = row.first.split(/\t/)
        if column[0].to_s == "DE"
          location = Location.new :country => column[0], :zip_code => column[1],
                                  :city => column[2], :lat => column[10], :lon => column[11]
        else
          location = Location.new :country => column[0], :zip_code => column[1],
                                  :city => column[7], :lat => column[10], :lon => column[11]
        end
        if location.valid?
          location.save!
        end
      end
    else
      puts "no SOURCE specified"
    end
  end
end