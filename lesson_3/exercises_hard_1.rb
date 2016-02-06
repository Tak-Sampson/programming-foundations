# exercises_hard_1.rb

# 1
# The reference to greeting returns nil
# This occurs since a variable greeting is initialized, but since the if false condition is
# never satisfied, greeting is never 'manually' assigned a value, and so is initialized to
# nil by default.

# 2
# {:a => "hi there"} is printed to the screen (returns nil)
# informal_greeting is initialized to the hash value 'hi', after which the underlying
# object pointed to is changed to 'hi there'. At this point greetings now points to
# a hash object which has been changed to {:a => "hi there"}

# 3
# A)
#   one is: one
#   two is: two
#   three is: three

# B)
#   one is: one
#   two is: two
#   three is: three

# C)
#   one is: two
#   two is: three
#   three is: one

# 4
def produce_uuid
  uuid = ''
  hex_arr = ((0..9).to_a + ('a'..'f').to_a).map { |arg| arg.to_s }
  sequence = [8, 4, 4, 4, 12]
  sequence.each_with_index do |num, i|
    num.times { uuid += hex_arr.sample }
    uuid += '-' unless i == sequence.length - 1
  end
  uuid
end

# 5
def is_a_number?(word)
end

def dot_separated_ip_address?(input_string)
  dot_separated_words = input_string.split(".")
  dot_separated_words.select { |word| is_a_number?(word) } == dot_separated_words &&
    dot_separated_words.length == 4
end
