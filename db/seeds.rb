# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'

csv_text = File.read(Rails.root.join('lib', 'seeds', 'cellgroups.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
    t = CellGroup.new
    t.name = row['Name']
    t.gender = row['Gender']
    t.save
    puts "cell group #{t.name} saved"
  end
  
puts "There are now #{CellGroup.count} rows in the cell group table"

csv_text = File.read(Rails.root.join('lib', 'seeds', 'largegroups.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
    t = LargeGroup.new
    t.date = row['Date']
    t.session_number = row['Session Number']
    t.semester = row['Semester']
    t.save
    puts "large group #{t.session_number}, #{t.semester} saved"
  end
  
puts "There are now #{LargeGroup.count} rows in the cell group table"

csv_text = File.read(Rails.root.join('lib', 'seeds', 'members.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
    t = Member.new
    t.name = row['Name']
    t.gender = row['Gender']
    t.is_leader = row['Is_Leader']
    t.year = row['Year']
    cell_group = CellGroup.where(name: row['Cell Group']).first
    if (!cell_group.nil?)
        t.cell_group_id = CellGroup.where(name: row['Cell Group']).first.id
      t.save
    end
    t.is_active = row['Is_Active']
    t.save
    puts "member #{t.name} saved"
  end
  
puts "There are now #{Member.count} rows in the cell group table"
