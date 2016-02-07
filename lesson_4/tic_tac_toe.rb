# tic_tac_toe.rb
require 'pry'
# Step 1: set up and display the board
board_state = { 'a1' => ' ', 'b1' => ' ', 'c1' => ' ', 'a2' => ' ', 'b2' => ' ',
                'c2' => ' ', 'a3' => ' ', 'b3' => ' ', 'c3' => ' ' }

def display_board(board_state)
  puts ''
  puts '   | a | b | c'
  puts '---+---+---+----'
  puts " 1 | #{board_state['a1']} | #{board_state['b1']} | #{board_state['c1']} "
  puts '---+---+---+----'
  puts " 2 | #{board_state['a2']} | #{board_state['b2']} | #{board_state['c2']} "
  puts '---+---+---+----'
  puts " 3 | #{board_state['a3']} | #{board_state['b3']} | #{board_state['c3']} "
  puts ''
end

rows = []

rows << { 'a1' => board_state['a1'], 'b1' => board_state['b1'], 'c1' => board_state['c1'] }
rows << { 'a2' => board_state['a2'], 'b2' => board_state['b2'], 'c2' => board_state['c2'] }
rows << { 'a3' => board_state['a3'], 'b3' => board_state['b3'], 'c3' => board_state['c3'] }

rows << { 'a1' => board_state['a1'], 'a2' => board_state['a2'], 'a3' => board_state['a3'] }
rows << { 'b1' => board_state['b1'], 'b2' => board_state['b2'], 'b3' => board_state['b3'] }
rows << { 'c1' => board_state['c1'], 'c2' => board_state['c2'], 'c3' => board_state['c3'] }

rows << { 'a1' => board_state['a1'], 'b2' => board_state['b2'], 'c3' => board_state['c3'] }
rows << { 'a3' => board_state['a3'], 'b2' => board_state['b2'], 'c1' => board_state['c1'] }

# Step 2: Player turn

def prompt(string)
  puts '=> ' + string
end

# player input
def player_choice(board_state)
  squares = board_state.keys
  choice = ''
  loop do
    puts 'Choose an unoccupied square:  (format e.g. \'a1\')'
    choice = gets.chomp
    if !squares.include?(choice)
      prompt 'Invalid entry. Please try again.'
    elsif !squares.select { |square| board_state[square] == ' ' }.include?(choice)
      prompt 'Square must be unoccupied. Please try again.'
    else
      prompt "You chose square #{choice}"
      break
    end
  end
  choice
end

def update_board(choice, symbol, board_state)
  board_state[choice].gsub!(' ', symbol) # mutate in order to have rows track the boardstate
end

# Step 3: Computer turn
def two_in_a_row(rows, player_symbol, computer_symbol) # return 3rd quare needed to finish a row
  square = ''
  rows.each do |row|
    if row.values.count(computer_symbol) == 2 && row.value?(' ')
      square = row.key(' ')
      break
    elsif row.values.count(player_symbol) == 2 && row.value?(' ')
      square = row.key(' ')
    end
  end
  square
end

def computer_choice(board_state, rows, player_symbol, computer_symbol)
  squares = board_state.keys
  choice = squares.select { |square| board_state[square] == ' ' }.sample
  unless two_in_a_row(rows, player_symbol, computer_symbol).empty?
    choice = two_in_a_row(rows, player_symbol, computer_symbol)
  end
  prompt "Computer chose #{choice}"
  choice
end

# Step 4: Determine winner or tie
#         need the 8 rows, also the outer 8 squares for computer strategy
def determine_win_or_tie(rows, player_symbol, computer_symbol)
  win_or_tie = ''
  win_or_tie = 'tie' if rows == rows.select { |row| !row.value?(' ') }
  rows.each do |row|
    if row.values.count(player_symbol) == 3
      win_or_tie = 'player'
    elsif row.values.count(computer_symbol) == 3
      win_or_tie = 'computer'
    end
  end
  win_or_tie
end

def print_end_message(winner)
  case winner
  when 'player'
    puts 'Congratulations! You win!'
  when 'computer'
    puts 'Computer wins. Better luck next time!'
  when 'tie'
    puts 'It\'s a tie!'
  end
end

# Step 5: Main game loop
puts 'Welcome to tic tac toe!'

name = ''
loop do
  puts 'What is your name?'
  name = gets.chomp
  break if !name.empty?
  prompt 'Please enter a valid name'
end

player_symbol = ''
computer_symbol = ''

loop do
  puts "Hi #{name}! Choose a symbol (must be one character other than a space)."
  player_symbol = gets.chomp
  break if player_symbol.length == 1 && player_symbol != ' '
  prompt 'Invalid symbol. Please try again'
end

if player_symbol == 'X' || player_symbol == 'x'
  computer_symbol = 'O'
else
  computer_symbol = 'X'
end

loop do
  # reinitialize board
  board_state.each_value { |square_contents| square_contents.replace(' ') }
  loop do
    # player's turn

    display_board(board_state)
    player_square = player_choice(board_state)
    update_board(player_square, player_symbol, board_state)
    display_board(board_state)

    # check for game over

    winner = determine_win_or_tie(rows, player_symbol, computer_symbol)
    print_end_message(winner)
    break if !winner.empty?

    # computer's turn

    computer_square = computer_choice(board_state, rows, player_symbol, computer_symbol)
    update_board(computer_square, computer_symbol, board_state)

    # check for game over

    winner = determine_win_or_tie(rows, player_symbol, computer_symbol)
    unless winner.empty?
      display_board(board_state)
      print_end_message(winner)
    end
    break if !winner.empty?
  end

  # Step 6: Play again
  puts 'Play again?  y) yes    press any other key to exit'
  response = gets.chomp
  break if response.downcase != 'y'
  puts "Ok!"
  puts ''
end

puts "Bye #{name}! Thank you for playing tic tac toe!"
