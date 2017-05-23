#!/usr/bin/env ruby

# Broc Nickodemus

# This program was created to add to make changes to the Superheroes Database (homework07.sqlite3.db)
# Its purpose is to view and manipulate the database via SQL

require 'sqlite3'

def executeInsertQuery(db,insert_query)
   db.execute(insert_query)
end

def formatAndPrint(array)
  array.each_with_index do |item, index|
    tmpStr = "#{item}".split(',')
    tmpStr[0] = tmpStr[0].delete('[]"')
    tmpStr[1] = tmpStr[1].delete('[]"')
    puts tmpStr[0].to_s + tmpStr[1].to_s
  end
end

def listSuperheroes(db)

  team_query = "SELECT superheroes.name, teams.name, villains.name
      FROM superheroes
      JOIN teams ON superheroes.team_id = teams.id
      JOIN villains ON superheroes.villain_id = villains.id;"

  results = db.execute(team_query)
  results.each do |row|
    puts row[0] # hero name
    puts "Team: " + row[1].to_s
    puts "Nemesis: " + row[2].to_s

    # get the superhero id
    superId = db.execute("SELECT superheroes.id FROM superheroes WHERE superheroes.name = \"" + row[0].to_s + "\";")

    powers_query = "SELECT superheroes.name, powers.name
      FROM powers, superheroes, powers_superheroes
      WHERE superheroes.id = powers_superheroes.superhero_id
      AND powers.id = powers_superheroes.power_id;"

    powerResults = db.execute(powers_query)
    #puts powerResults.to_s
    powerResults.each do |powrow|
      if (powrow[0] == row[0])
        puts "Powers: " + powrow[1]
      end
    end

    colors_query = "SELECT superheroes.name, colors.name
      FROM colors, superheroes, colors_superheroes
      WHERE superheroes.id = colors_superheroes.superhero_id
      AND colors.id = colors_superheroes.color_id;"

    colorResults = db.execute(colors_query)
    colorResults.each do |colorrow|
      if (colorrow[0] == row[0])
        puts "Costume colors: " + colorrow[1]
      end
    end
    puts # create newline
  end

  puts "(A)dd a new superhero, or (Q)uit ?"
  input = gets.chomp
  if (input == "A")
    puts "please add a superhero name"
    newName = gets.chomp

    villains = executeInsertQuery(db,"SELECT * FROM villains;")
    formatAndPrint(villains) # reformat for printing

    puts "please add a superhero villain"
    newVillain = gets.chomp
    executeInsertQuery(db,"INSERT INTO villains(name) VALUES('" + newVillain + "');")
    villainId = executeInsertQuery(db,"SELECT villains.id FROM villains WHERE villains.name = \"" + newVillain + "\";")

    teams = executeInsertQuery(db,"SELECT * FROM teams;")
    formatAndPrint(teams)

    puts "please add a team name"
    newTeam = gets.chomp
    executeInsertQuery(db,"INSERT INTO teams(name) VALUES('" + newTeam + "');")
    teamId = executeInsertQuery(db,"SELECT teams.id FROM teams WHERE teams.name = \"" + newTeam + "\";")

    villainId = villainId.to_s
    villainId = villainId.delete('[]')
    teamId = teamId.to_s
    teamId = teamId.delete('[]') # remove square brackets

    executeInsertQuery(db,"INSERT INTO superheroes(name,villain_id,team_id) VALUES('" + newName + "','" + villainId + "','" + teamId + "');")
    superheroId = executeInsertQuery(db,"SELECT superheroes.id FROM superheroes WHERE superheroes.name = \"" + newName + "\";")
    superheroId = superheroId.to_s
    superheroId = superheroId.delete('[]')

    colors = executeInsertQuery(db,"SELECT * FROM colors;")
    formatAndPrint(colors)
    puts "please add color(s) in a comma separated list (brown,red,purple)"
    colors = gets.chomp
    array = colors.split(',')
    array.each_with_index do |item, index|
      executeInsertQuery(db,"INSERT INTO colors(name) VALUES('#{item}');") # insert colors into tablename
      colorId = executeInsertQuery(db,"SELECT colors.id FROM colors WHERE colors.name = \"#{item}\";") # get the indexes
      colorId = colorId.to_s
      colorId = colorId.delete('[]')
      executeInsertQuery(db,"INSERT INTO colors_superheroes(color_id,superhero_id) VALUES('" + colorId + "','" + superheroId + "');")
    end

    powers = executeInsertQuery(db,"SELECT * FROM powers;")
    formatAndPrint(powers)
    puts "please add power(s) in a comma separated list (Death Ray,Night Vision,Bad Breath)"
    powers = gets.chomp
    array = powers.split(',')
    array.each_with_index do |item, index|
      executeInsertQuery(db,"INSERT INTO powers(name) VALUES('#{item}');")
      powerId = executeInsertQuery(db,"SELECT powers.id FROM powers WHERE powers.name = \"#{item}\";") # get the indexes
      powerId = powerId.to_s
      powerId = powerId.delete('[]')
      executeInsertQuery(db,"INSERT INTO powers_superheroes(power_id,superhero_id) VALUES('" + powerId + "','" + superheroId + "');")
    end
  elsif (input == "Q") # do nothing
  end

end

def listVillains(db)
  villain_query = "SELECT villains.name FROM villains"
  results = db.execute(villain_query)
  results.each do |row|
    puts row[0]
  end
  puts "(A)dd a new villain, or (Q)uit ?"
  input = gets.chomp
  if (input == "A")
    puts "please add a villain (Joker)"
    villain = gets.chomp
    executeInsertQuery(db,"INSERT INTO villains(name) VALUES('" + villain + "');")
  elsif (input == "Q") # do nothing
  end
end

def listTeams(db)
  team_query = "SELECT teams.name FROM teams"
  results = db.execute(team_query)
  results.each do |row|
    puts row[0]
  end
  puts "(A)dd a new team, or (Q)uit ?"
  input = gets.chomp
  if (input == "A")
    puts "please add a team (Justice League)"
    team = gets.chomp
    executeInsertQuery(db,"INSERT INTO teams(name) VALUES('" + team + "');")
  elsif (input == "Q") # do nothing
  end
end

def listPowers(db)
  power_query = "SELECT powers.name FROM powers"
  results = db.execute(power_query)
  results.each do |row|
    puts row[0]
  end
  puts "(A)dd a new power, or (Q)uit ?"
  input = gets.chomp
  if (input == "A")
    puts "please add power(s) in a comma separated list (Death Ray,Night Vision,Bad Breath)"
    powers = gets.chomp
    array = powers.split(',')
    array.each_with_index do |item, index|
      executeInsertQuery(db,"INSERT INTO powers(name) VALUES('#{item}');")
    end
  elsif (input == "Q") # do nothing
  end
end

def listColors(db)
  color_query = "SELECT colors.name FROM colors"
  results = db.execute(color_query)
  results.each do |row|
    puts row[0]
  end
  puts "(A)dd a new color, or (Q)uit ?"
  input = gets.chomp
  if (input == "A")
    puts "please add color(s) in a comma separated list (brown,red,purple)"
    colors = gets.chomp
    array = colors.split(',')
    array.each_with_index do |item, index|
      executeInsertQuery(db,"INSERT INTO colors(name) VALUES('#{item}');")
    end
  elsif (input == "Q") # do nothing
  end
end

db = SQLite3::Database.new "homework07.sqlite3.db"

puts "Welcome to the superheroes archive!"
puts "1. Superheroes"
puts "2. Villains"
puts "3. Teams"
puts "4. Powers"
puts "5. Colors"
puts "please enter a number..."

num = gets.chomp

if (num == "1")
  listSuperheroes(db)
elsif (num == "2")
  listVillains(db)
elsif (num == "3")
  listTeams(db)
elsif (num == "4")
  listPowers(db)
elsif (num == "5")
  listColors(db)
end

db.close
