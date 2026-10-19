# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

CATEGORIES = {
  "Climbing" => [
    "Bouldering",
    "Sport Climbing",
    "Trad Climbing",
    "Ice & Mixed",
    "Big Wall & Aid",
    "Gym & Training"
  ],
  "Mountaineering" => [
    "Axes & Tools",
    "Crampons & Traction",
    "Glacier Travel",
    "Avalanche Safety",
    "High Altitude"
  ],
  "Camping & Hiking" => [
    "Tents & Shelters",
    "Sleeping",
    "Backpacks",
    "Camp Kitchen",
    "Navigation"
  ]
}.freeze

CATEGORIES.each do |parent_name, child_names|
  parent = Category.find_or_create_by!(name: parent_name)
  child_names.each do |child_name|
    Category.find_or_create_by!(name: child_name, parent: parent)
  end
end
