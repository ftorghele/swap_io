class AddCategories < ActiveRecord::Migration
  def up
    # cleaning up, reset auto-increment
    ActiveRecord::Base.connection.execute("TRUNCATE TABLE categories")

    Category.create(:title => "Kulturen kennenlernen")
    Category.create(:title => "Aktiv bewegen")
    Category.create(:title => "Bewusst leben")
    Category.create(:title => "Geschickt handwerken")
    Category.create(:title => "Kulinarisches entdecken")
    Category.create(:title => "Freizeit gestalten")
    Category.create(:title => "Technik verstehen")
    Category.create(:title => "Gestalterisch entfalten")
    Category.create(:title => "Theorie begreifen")
    Category.create(:title => "Irgendwie kurios")
  end
end
