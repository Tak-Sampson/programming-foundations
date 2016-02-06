# exerciese_medium_1.rb

# 1
(0..9).each { |spaces| puts ' ' * spaces + "The Flintstones Rock!" }

# 2
statement = "The Flintstones Rock"
statement_hsh = {}
statement.chars.each { |letter| statement_hsh[letter] = statement.count(letter) }

# 3
# The problem is that (40 + 2) is a fixnum, not a string
puts "the value of 40 + 2 is " + (40 + 2).to_s
puts "the value of 40 + 2 is #{(40 + 2)}"

# 4
# The first program prints 1 and 3 to the screen
# The second program prints 1 and 2
# In each case, at the beginning of each iteration, the computer chooses the next index
# in the array as it exists at that moment in time, after having been modified during the
# previous iteration. e.g. in the first program, after the first iteration, numbers is
# [2,3,4]. The second iteration looks for numbers[1], which is at that point 3, not 2. Then
# numbers is modified to be [3,4]. Thus on the third iteration, numbers[2] no longer exists,
# so the program exits without ever printing 4.

# 5
def factors(number)
  dividend = number
  divisors = []
  while dividend > 0
    divisors << number / dividend if number % dividend == 0
    dividend -= 1
  end
  divisors
end
# Bonus 1: number % dividend == 0 checks if the candidate divisor in fact divides the dividend.
# Bonus 2: the second to last line ensures that the method's return value is indeed the
#          desired array of divisors.

# 6
# The key difference here is that buffer is mutated when rolling_buffer1 is called on it,
# whereas rolling_buffer2 does not modify input_array.

# 7
# The problem is one of variable scope; the method fib has no access to the local variable, limit.
# We could define fib(first_num, second_num, limit), so that the variable can be accessed by the
# method.

# 8
def titleize(string)
  string.split.map { |word| word.capitalize }.join(' ')
end

# 9
munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female" }
}

munsters.each_value do |person|
  case person["age"]
  when 0..17
    person["age_group"] = "kid"
  when 18..64
    person["age_group"] = "adult"
  else
    person["age_group"] = "senior"
  end
end
