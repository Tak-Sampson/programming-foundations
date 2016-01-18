# rock_paper_scissors_spock_lizard.rb
require 'pry'
def prompt(message)
  Kernel.puts("=> #{message}")
end

def winner(player, computer)
  relation = (LEGAL_MOVES.keys.index(player) - LEGAL_MOVES.keys.index(computer)) % 5
  if relation == 0 # tie
    'tie'
  elsif relation.odd? # win
    'player'
  elsif relation.even? # lose
    'computer'
  end
end

def update_records(winner, records)
  case winner
  when 'tie'
    records[2] += 1
  when 'player'
    records[0] += 1
  when 'computer'
    records[1] += 1
  end
end

def display_results(winner, player, computer, beats)
  case winner
  when 'tie'
    prompt("It's a tie!")
  when 'player'
    prompt("#{player.capitalize} #{beats} #{computer}. Congratulations, you win!")
  when 'computer'
    prompt("#{computer.capitalize} #{beats} #{player}. Computer wins.")
  end
end

def display_records(records)
  num = %w(wins losses ties)
  singular = %w(win loss tie)
  records.each_with_index do |arg, i|
    (num[i] = singular[i]) if arg == 1
  end
  prompt("Records:   #{records[0]} #{num[0]}   #{records[1]} #{num[1]}   #{records[2]} #{num[2]}")
end

puts ''
prompt("Welcome to Rock, Paper, Scissors, Spock, Lizard!!!")

LEGAL_MOVES = { 'r' => 'rock', 'p' => 'paper', 'sc' => 'scissors',
                'sp' => 'spock', 'l' => 'lizard' }
BEATS = { %w(p sc) => 'cuts', %w(p r) => 'covers', %w(l r) => 'crushes',
          %w(l sp) => 'poisons', %w(sc sp) => 'smashes', %w(l sc) => 'decapitates',
          %w(l p) => 'eats', %w(p sp) => 'disproves', %w(r sp) => 'vaporizes',
          %w(r sc) => 'crushes' }

selections = []
LEGAL_MOVES.to_a.each do |arg|
  selections << (arg[0] + ')')
  selections << (arg[1] + '  ')
end
moves = LEGAL_MOVES.keys

loop do # main game loop
  round = 1
  records = [0, 0, 0] # wins, losses, ties
  prompt("First player to win five rounds wins.")
  puts ''

  loop do # game rounds loop
    prompt("Round #{round}")
    puts ''
    player_move = ''

    loop do
      prompt("Make your selection:
             #{selections.join(' ')}")
      player_move = Kernel.gets().chomp()
      break if LEGAL_MOVES.keys.include?(player_move.downcase)
      prompt("Invalid entry. You must choose either #{moves[0..(moves.length - 2)].join(', ') + ', or ' + moves.last}.")
      puts ''
    end

    computer_move = LEGAL_MOVES.keys.sample()

    player_val = "#{LEGAL_MOVES[player_move]}"
    computer_val = "#{LEGAL_MOVES[computer_move]}"
    key = [player_move, computer_move].sort
    beats = BEATS[key]

    puts ''
    prompt("You chose #{player_val}. Computer chose #{computer_val}.")

    winning_player = winner(player_move, computer_move)
    update_records(winning_player, records)

    display_results(winning_player, player_val, computer_val, beats)
    puts ''
    display_records(records)
    break if (records[0] == 5) || (records[1] == 5)

    puts ''
    round += 1
  end

  if records[0] == 5
    prompt("Congratulations! You won five rounds!")
  elsif records[1] == 5
    prompt("Computer wins five rounds. Better luck next time!")
    puts ''
  end

  puts ''
  prompt("Would you like to play again?   y) yes      press any other key to exit")
  answer = Kernel.gets().chomp()
  break unless answer.downcase == 'y'
end

prompt("Thank you for playing Rock, Paper, Scissors, Spock, Lizard!")
