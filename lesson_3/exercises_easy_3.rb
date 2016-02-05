# exerciese_easy_3.rb

# 1
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

# 2
flintstones << "Dino"

# 3
flintstones.concat(%w(Dino Hoppy))

# 4
advice = "Few things in life are as important as house training your pet dinosaur."
advice.slice!("Few things in life are as important as ")
# advice.slice returns the same value but does not mutate the caller

# 5
statement = "The Flintstones Rock!"
statement.count('t')
statement.scan('t').count

# 6
title = "Flintstone Family Members"
title.center(40)
