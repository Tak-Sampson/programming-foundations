# exercises_easy_1.rb

# 1
#   prints: 1
#           2
#           2
#           3  to screen (.uniq does not mutate caller)


# 2
#   1) != means 'not equal to' used in booleans, often in conditionals
#   2) !user_name => false, (unless user_name is false or nil) since anything 
#      other than false or nil returns true
#   3) <some_method>! usually (not always) indicates that the method mutates the
#      caller e.g. words.uniq! modifies words
#   4) Putting ? before something will yield a syntax error, though ? : is the 
#      ternary operator
#   5) Putting ? after a method doesn't constitute proper syntax in itself, but 
#      by convention many methods that return a boolean end in ?, similar to how 
#      by convention many that end in ! change the object
#   6) !!<object> returns the truth value of <object> (!! is a double negative)


# 3
advice = "Few things in life are as important as house training your pet dinosaur."
advice.gsub!('important', 'urgent')


# 4
numbers = [1, 2, 3, 4, 5]
numbers.delete_at(1) # => 2  deletes argument at position 1, numbers is [1,3,4,5]
numbers = [1, 2, 3, 4, 5]
numbers.delete(1) # => 1     deletes all instances of 1, leaving [2,3,4,5]


# 5
(10..100).include?(42)


# 6
famous_words = "seven years ago..."
famous_words.prepend("Four score and ")
famous_words = "seven years ago..."
famous_words.insert(0, "Four score and ")


# 7
def add_eight(number)
  number + 8
end

number = 2

how_deep = "number"
5.times { how_deep.gsub!("number", "add_eight(number)") }

p how_deep

eval(how_deep) # => 42


# 8
flintstones = ["Fred", "Wilma"]
flintstones << ["Barney", "Betty"]
flintstones << ["BamBam", "Pebbles"]

flintstones.flatten!


# 9
flintstones = { "Fred" => 0, "Wilma" => 1, "Barney" => 2, "Betty" => 3, "BamBam" => 4, "Pebbles" => 5 }
barney_arr = flintstones.assoc("Barney")


# 10
flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]
flint_hsh = {}
flintstones.each_with_index{|arg, i| flint_hsh[arg] = i }

p flint_hsh





