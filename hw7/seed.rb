#!/usr/bin/env ruby

# Broc Nickodemus

# This program was created to add new entries to the Superheroes Database (homework07.sqlite3.db)
# It adds new entries via SQL

require 'sqlite3'

def executeInsertQuery(db,insert_query)
   db.execute(insert_query)
end

def executeDeleteQuery(db)
  db.execute("DELETE FROM villains")
  db.execute("DELETE FROM teams")
  db.execute("DELETE FROM powers")
  db.execute("DELETE FROM colors")
  db.execute("DELETE FROM superheroes")
end

db = SQLite3::Database.new "homework07.sqlite3.db"

#insert three villains records
executeInsertQuery(db,"INSERT INTO villains(name) VALUES('Joker');")
executeInsertQuery(db,"INSERT INTO villains(name) VALUES('Dr. Evil');")
executeInsertQuery(db,"INSERT INTO villains(name) VALUES('Buddy');")

# insert three teams records
executeInsertQuery(db,"INSERT INTO teams(name) VALUES('Justice League');")
executeInsertQuery(db,"INSERT INTO teams(name) VALUES('X-Men');")
executeInsertQuery(db,"INSERT INTO teams(name) VALUES('Super Heroic Team');")

# insert seven powers records
executeInsertQuery(db,"INSERT INTO powers(name) VALUES('Utility Belt');")
executeInsertQuery(db,"INSERT INTO powers(name) VALUES('Fly');")
executeInsertQuery(db,"INSERT INTO powers(name) VALUES('Heat Vision');")
executeInsertQuery(db,"INSERT INTO powers(name) VALUES('Invisibility');")
executeInsertQuery(db,"INSERT INTO powers(name) VALUES('Super Sonic Shout');")
executeInsertQuery(db,"INSERT INTO powers(name) VALUES('Super Strength');")
executeInsertQuery(db,"INSERT INTO powers(name) VALUES('Jump High');")

# insert seven colors records
executeInsertQuery(db,"INSERT INTO colors(name) VALUES('Black');")
executeInsertQuery(db,"INSERT INTO colors(name) VALUES('Yellow');")
executeInsertQuery(db,"INSERT INTO colors(name) VALUES('Purple');")
executeInsertQuery(db,"INSERT INTO colors(name) VALUES('White');")
executeInsertQuery(db,"INSERT INTO colors(name) VALUES('Red');")
executeInsertQuery(db,"INSERT INTO colors(name) VALUES('Blue');")
executeInsertQuery(db,"INSERT INTO colors(name) VALUES('Green');")

# insert three superheroes records
executeInsertQuery(db,"INSERT INTO superheroes(name,villain_id,team_id) VALUES('Batman','1','1');")
executeInsertQuery(db,"INSERT INTO colors_superheroes(color_id,superhero_id) VALUES('1','1');")
executeInsertQuery(db,"INSERT INTO colors_superheroes(color_id,superhero_id) VALUES('2','1');")
executeInsertQuery(db,"INSERT INTO powers_superheroes(superhero_id,power_id) VALUES('1','1');")

executeInsertQuery(db,"INSERT INTO superheroes(name,villain_id,team_id) VALUES('Wonder Women','2','2');")
executeInsertQuery(db,"INSERT INTO colors_superheroes(color_id,superhero_id) VALUES('2','2');")
executeInsertQuery(db,"INSERT INTO powers_superheroes(superhero_id,power_id) VALUES('2','2');")

executeInsertQuery(db,"INSERT INTO superheroes(name,villain_id,team_id) VALUES('Superman','3','3');")
executeInsertQuery(db,"INSERT INTO colors_superheroes(color_id,superhero_id) VALUES('3','3');")
executeInsertQuery(db,"INSERT INTO powers_superheroes(superhero_id,power_id) VALUES('3','3');")

# check to make sure insert statement was successful
=begin
select_query = "SELECT * FROM superheroes;"
results = db.execute(select_query)

results.each do |row|
  p row[1]
end
=end

db.close
