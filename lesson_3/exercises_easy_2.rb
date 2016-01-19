# exercises_easy_2.rb

# 1
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }
ages.has_key?("Spot")
ages.key?("Spot")
ages.member?("Spot")


# 2
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }
sum = 0
ages.values.each{|age| sum += age}
# or
ages.values.inject(:+)



# 3
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }
ages.delete_if{|key, val| val >= 100 }


# 4
munsters_description = "The Munsters are creepy in a good way."

munsters_description.capitalize!
munsters_description.swapcase!
munsters_description.downcase!
munsters_description.upcase!


# 5
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10 }
additional_ages = { "Marilyn" => 22, "Spot" => 237 }
ages.merge!(additional_ages)


# 6
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }
ages.values.min


# 7
advice = "Few things in life are as important as house training your pet dinosaur."
advice.include?("Dino")


# 8
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
flintstones.index{ |name| name.start_with?("Be")}


# 9
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
flintstones.map! do |name| 
  name[0, 3]
end


# 10
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
flintstones.map! { |name| name[0, 3] }
