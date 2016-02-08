# twenty_one.rb
require 'pry'
# Initialize Deck
hsh_arr = []
full_deck = ((2..10).to_a + ['J', 'Q', 'K', 'A'] ).product(['d','c','h','s'])
full_deck.each do |arg|
  hsh_arr << {'number' => arg[0], 'suit' => arg[1] }
end
FULL_DECK = hsh_arr

# card e.g. {number => k, suit => s}
# hand: hash {cards =>  array of cards , status => status_of_hand }
player_hands = [ {'cards' => [], 'status' => 'live'} ] # will be array of hand hashes
dealer_hand = {'cards' => [], 'status' => 'live'} # hash containing cards

def value(hand)
  total = 0
  hand['cards'].each do |card| # treating ace as 1
    case card['number']
    when 'A'
      total += 1
    when 2..10
      total += card['number']
    else # J, Q, K
      total += 10
    end
  end
  hand['cards'].count { |card| card['number'] == 'A' }.times do
    total += 10 if total < 12
  end
  total
end


def display_hand(hand, pointer)
  card_str = ''
  value_str = ''
  if value(hand) < 10
    value_str = " #{value(hand)}"
  else
    value_str = "#{value(hand)}"
  end
  hand['cards'].each { |card| card_str << "   #{card['number'].to_s} (#{card['suit']})" }
  puts "#{pointer} | value: #{value_str} |" + card_str
end

def deal(hand, remaining_deck)
  hand['cards'] << remaining_deck.pop
end

def update_status(hand, new_status)
  hand['status'].replace(new_status)
end

def display_game_state(dealer_hand, player_hands, which_hand_index, whose_turn)
  cursor = '       '
  shown_card = dealer_hand['cards'][0]
  puts '____________________________________________________________________'
  puts 'Dealer\'s Hand:'
  if whose_turn == 'dealer'
    display_hand(dealer_hand, '       ')
  else
    puts "        | value:  ? |   #{shown_card['number'].to_s} (#{shown_card['suit']})   < other card face down >"
  end
  puts '____________________________________________________________________'
  
  if player_hands.length == 1
    puts 'Your Hand:'
  else
    puts 'Your Hands:'
  end
  player_hands.select.each_with_index do |hand, i|
    case hand['status']
    when 'stayed'
      cursor = ' stayed'
    when '21'
      cursor = '     21'
    when 'bust'
      cursor = '   bust'
    else
      cursor = '       '
    end
    if i == which_hand_index && hand['status'] == 'live'
      display_hand(hand, '     =>')
    else
      display_hand(hand, cursor)
    end
  end
  puts ''
end

def display_end_state(player_hands, dealer_hand)
  outcome = '       '

  player_hands.each do |hand|
    if hand['status'] == 'bust'
      update_status(hand, '   loss')
    elsif value(hand) > value(dealer_hand)
      update_status(hand, '   win!')
    elsif value(hand) == value(dealer_hand)
      update_status(hand, '   tie ')
    elsif value(hand) < value(dealer_hand) && value(dealer_hand) <= 21
      update_status(hand, '   loss')
    else # player hasn't busted but dealer has
      update_status(hand, '   win!')
    end
  end

  if player_hands == player_hands.select { |hand| hand['status'] == '   loss' }
    if value(dealer_hand) > 21
      outcome = '   bust'
    else
      outcome = '   win!'
    end
  elsif player_hands == player_hands.select { |hand| hand['status'] == '   tie' }
    outcome = '   tie '
  elsif player_hands == player_hands.select { |hand| hand['status'] == '   win!' }
    outcome = '   loss'
  else
    oucome = '   -   '
  end

  puts '____________________________________________________________________'
  puts 'Dealer\'s Hand:'
  display_hand(dealer_hand, outcome)
  puts '____________________________________________________________________'
  if player_hands.length == 1
    puts 'Your Hand:'
  else
    puts 'Your Hands:'
  end
  player_hands.each { |hand| display_hand(hand, hand['status']) }
end

# Player turn validation
def valid_choice(hand, player_hands)
  invalid_choices = 0
  options = ['1', '2']
  options_str = '  1) hit   2) stay'
  if hand['cards'].length == 2 && hand['cards'][0]['number'] == hand['cards'][1]['number'] && player_hands.size <= 4
    options << '3'
    options_str << '   3) split'
  end
  choice = ''
  loop do
    puts 'What would you like to do? ' + options_str
    choice = gets.chomp
    break if options.include?(choice)
    puts '=> Invalid entry. Please try again.'
    invalid_choices += 1

    if invalid_choices == 3
      sleep 1
      choice = nil
      break
    end
  end
  choice
end

# Main Game Loop

name = ''
loop do
  system "clear"
  puts 'Welcome to 21 (Twenty One)!'
  2.times {puts ''}
  puts 'What is your name?'
  response = gets.chomp
  if response.empty?
    puts 'Please enter a valid name'
    sleep 1
  else
    name = response
    break
  end
end

# gameplay

loop do
  # Initialize Deck and hands
  remaining_deck = []
  remaining_deck.replace(FULL_DECK)
  remaining_deck.shuffle!

  player_hands.replace([ {'cards' => [], 'status' => 'live'} ])
  dealer_hand.replace({'cards' => [], 'status' => 'live'})

  system "clear"
  puts "Ok #{name}! Let's begin"
  puts ''
  puts "Dealing cards..."
  sleep 1.5
  system "clear"

  # start by dealing 2 cards to each.
  2.times do
    deal(player_hands[0], remaining_deck)
    deal(dealer_hand, remaining_deck)
  end
  # check if dealer won
  #   if so display winner
  if value(dealer_hand) == 21
    puts 'Dealer got 21. Better luck next time!'
    puts ''
    display_end_state(player_hands, dealer_hand)
    break
  end

  # display gamestate
  # (for each player)
  # for each hand
  #   display
  #   give valid options until hand not live
  # do until no live hands
  player_hands.each_with_index do |hand, i|
    if value(hand) == 21
      update_status(hand, '21')
    elsif value(hand) > 21
      update_status(hand, 'bust')
    end

    until hand['status'] != 'live'
      
      system "clear"
      puts 'Your turn'
      puts ''
      display_game_state(dealer_hand, player_hands, i, 'player')
      
      player_choice = valid_choice(hand, player_hands)

      # hit
      deal(hand, remaining_deck) if player_choice == '1'
      # stay
      update_status(hand, 'stayed') if player_choice == '2'
      # split -  modifies object being iterated over! This is intentional **********
      player_hands << {'cards' => [hand['cards'].pop], 'status' => 'live'} if player_choice == '3'

      # check for 21 or bust and update appropriately
      if value(hand) == 21
        update_status(hand, '21')
      elsif value(hand) > 21
        update_status(hand, 'bust')
      end
    end
  end

  # Dealer's turn

  system "clear"
  puts 'Revealing Dealer\'s cards...'
  puts ''
  display_game_state(dealer_hand, player_hands, 0, 'player')
  sleep 2.5

  system "clear"
  puts 'Dealer\'s turn:'
  puts ''
  display_game_state(dealer_hand, player_hands, 0, 'dealer')

  until dealer_hand['status'] != 'live'
    sleep 1.5
    system "clear"

    case value(dealer_hand)
    when 0..16
      puts 'Dealer hits!'
      puts ''
      display_game_state(dealer_hand, player_hands, 0, 'dealer')
      deal(dealer_hand, remaining_deck)
    when 17..20
      puts 'Dealer stays'
      puts ''
      display_game_state(dealer_hand, player_hands, 0, 'dealer')
      update_status(dealer_hand, 'stayed')
    when 21
      puts 'Dealer gets 21!'
      puts ''
      display_game_state(dealer_hand, player_hands, 0, 'dealer')
      update_status(dealer_hand, '21')
    else
      puts 'Dealer busts!'
      puts ''
      display_game_state(dealer_hand, player_hands, 0, 'dealer')
      update_status(dealer_hand, 'bust')
    end
  end

  sleep 2
  system "clear"

  # Report results
  puts 'Results of game:'
  puts ''
  display_end_state(player_hands, dealer_hand)

  # Play again?
  3.times {puts ''}
  puts 'Would you like to play again?  y) yes   press any other key to exit'
  response = gets.chomp

  break unless response.downcase == 'y'
end

puts "Bye #{name}! Thank you for playing!"
3.times {puts ''}





