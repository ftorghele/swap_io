class ImportLocations < ActiveRecord::Migration
  def up
    puts "importing AT locations"
    system "cd #{Rails.root} ; bundle exec rake import:locations SOURCE=db/zip_codes/AT.txt"
    puts "importing DE locations"
    system "cd #{Rails.root} ; bundle exec rake import:locations SOURCE=db/zip_codes/DE.txt"
    puts "importing CH locations"
    system "cd #{Rails.root} ; bundle exec rake import:locations SOURCE=db/zip_codes/CH.txt"
  end
end
