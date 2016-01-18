# rock_paper_scissors.rb

def prompt(message)
  Kernel.puts("=> #{message}")
end

def winner(player, computer)
  case (LEGAL_MOVES.keys.index(player) - LEGAL_MOVES.keys.index(computer)) % 3
  when 0 # tie
    'tie'
  when 1 # win
    'player'
  when 2 # lose
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

def display_results(winner, player_move, computer_move)
  case winner
  when 'tie'
    prompt("It's a tie!")
  when 'player'
    prompt("#{LEGAL_MOVES[player_move][0].capitalize} #{LEGAL_MOVES[player_move][1]}. Congratulations, you win!")
  when 'computer'
    prompt("#{LEGAL_MOVES[computer_move][0].capitalize} #{LEGAL_MOVES[computer_move][1]}. Computer wins.")
  end
end

def display_records(records)
  prompt("Records:   #{records[0]} wins   #{records[1]} losses   #{records[2]} ties")
end

prompt("Welcome to Rock, Paper, Scissors!!!")
LEGAL_MOVES = { 'r' => ['rock', 'breaks scissors'], 'p' => ['paper', 'envelops rock'],
                's' => ['scissors', 'cuts paper'] }
selections = []
LEGAL_MOVES.to_a.each do |arg|
  selections << (arg[0] + ')')
  selections << (arg[1][0] + '  ')
end
moves = LEGAL_MOVES.keys
round = 1
records = [0, 0, 0] # wins, losses, ties

loop do # main game loop
  prompt("Round #{round}")
  puts ''
  player_move = ''

  loop do
    prompt("Make your selection:  #{selections.join(' ')}")
    player_move = Kernel.gets().chomp()
    break if LEGAL_MOVES.keys.include?(player_move.downcase)
    prompt("Invalid entry. You must choose either #{moves[0..(moves.length - 2)].join(', ') + ', or ' + moves.last}.")
  end

  computer_move = LEGAL_MOVES.keys.sample()

  prompt("You chose #{LEGAL_MOVES[player_move][0]}. Computer chose #{LEGAL_MOVES[computer_move][0]}.")

  winning_player = winner(player_move, computer_move)
  update_records(winning_player, records)

  display_results(winning_player, player_move, computer_move)
  display_records(records)

  puts ''
  prompt("Would you like to play again?   y) yes      press any other key to exit")
  answer = Kernel.gets().chomp()
  break unless answer.downcase == 'y'

  round += 1
end

prompt("Thank you for playing Rock, Paper, Scissors!")
