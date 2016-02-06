# exercises_medium_2.rb

# 1
munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" }
}
total_male_age = 0
munsters.each_value { |hsh| total_male_age += hsh["age"] if hsh["gender"] == "male" }

# 2
munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female" }
}
munsters.each do |name, info|
  puts "#{name} is a #{info['age']} year old #{info['gender']}."
end

# 3
def clear_method(a_string_param, an_array_param)
  a_string_param += "rutabaga"
  an_array_param += ["rutabaga"]
  return a_string_param, an_array_param
end

my_string = "pumpkins"
my_array = ["pumpkins"]
clear_method(my_string, my_array)

puts "My string looks like this now: #{my_string}"
puts "My array looks like this now: #{my_array}"

# 4
sentence = "Humpty Dumpty sat on a wall."
p sentence.split(/\W/).reverse.join(' ') + '.'

# 5
# output is 34 (since mess_with_it does not modify the caller)

# 6
# The family's data has indeed been altered, since when the method is called on munsters, it is
# the object id of munsters that is passed to the method, and the hash is subsequently mutated.

# 7
# The call results in the word paper being printed to the screen.
# puts rps(rps(rps("rock", "paper"), rps("rock", "scissors")), "rock") <=>
# puts rps(rps("paper", "rock"), "rock") <=> puts rps("paper", "rock") <=>
# puts "paper"

# 8
# foo always returns "yes", so bar(foo) always renders param == "no" to be false.
# Thus the output must be "no".
