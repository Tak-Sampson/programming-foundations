# twenty_one.rb
require 'pry'
# Initialize Deck
hsh_arr = []
full_deck = ((2..10).to_a + ['J', 'Q', 'K', 'A']).product(['d', 'c', 'h', 's'])
full_deck.each do |arg|
  hsh_arr << { 'number' => arg[0], 'suit' => arg[1] }
end
FULL_DECK = hsh_arr

# card e.g. {number => k, suit => s}
# hand: hash {cards =>  array of cards , status => status_of_hand }
player_hands = [{ 'cards' => [], 'status' => 'live' }] # will be array of hand hashes
dealer_hand = { 'cards' => [], 'status' => 'live' } # hash containing cards

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
  hand['cards'].each { |card| card_str << "   #{card['number']} (#{card['suit']})" }
  puts "#{pointer} | value: #{value_str} |" + card_str
end

def deal(hand, remaining_deck)
  hand['cards'] << remaining_deck.pop
end

def update_status(hand, new_status)
  hand['status'].replace(new_status)
end

def all_same_status?(players, status)
  players == players.select { |player| player['player_hands'] == player['player_hands'].select { |hand| hand['status'] == status } }
end

def display_game_state(dealer_hand, player, which_hand_index, whose_turn)
  cursor = '       '
  shown_card = dealer_hand['cards'][0]
  puts '____________________________________________________________________'
  puts 'Dealer\'s Hand:'
  if whose_turn == 'dealer'
    display_hand(dealer_hand, '       ')
  else
    puts "        | value:  ? |   #{shown_card['number']} (#{shown_card['suit']})   < other card face down >"
  end
  puts '____________________________________________________________________'

  if player['player_hands'].length == 1
    puts "#{player['player_name']}'s Hand:"
  else
    puts "#{player['player_name']}'s Hands:"
  end
  player['player_hands'].select.each_with_index do |hand, i|
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

def display_end_state(players, dealer_hand)
  outcome = '       '

  players.each do |player|
    player['player_hands'].each do |hand|
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
  end

  if all_same_status?(players, '   loss')
    if value(dealer_hand) > 21
      outcome = '   bust'
    else
      outcome = '   win!'
    end
  elsif all_same_status?(players, '   tie ')
    outcome = '   tie '
  elsif all_same_status?(players, '   win!')
    outcome = '   loss'
  else
    outcome = '   -   '
  end

  puts '____________________________________________________________________'
  puts 'Dealer\'s Hand:'
  display_hand(dealer_hand, outcome)
  puts '____________________________________________________________________'
  players.each do |player|
    puts '____________________________________________________________________'
    if player['player_hands'].length == 1
      puts "#{player['player_name']}'s Hand:"
    else
      puts "#{player['player_name']}'s Hands:"
    end
    player['player_hands'].each { |hand| display_hand(hand, hand['status']) }
  end
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
    end
    break if invalid_choices == 3
  end
  choice
end

# Main Game Loop
players = [] # { player_name => 'name', player_hands => array_of_hand_hashes }
unnamed_players = 0

loop do
  system "clear"
  puts 'Welcome to 21 (Twenty One)!'
  2.times { puts '' }
  puts 'How many players? 1, 2, 3, or 4'
  response = gets.chomp
  if !['1', '2', '3', '4'].include?(response)
    puts 'Please enter a valid number'
    sleep 1
  else
    unnamed_players = response.to_i
    break
  end
end

player_num = 1
until unnamed_players == 0
  loop do
    system "clear"
    puts 'Welcome to 21 (Twenty One)!'
    2.times { puts '' }
    puts "Player #{player_num}: What is your name?"
    response = gets.chomp
    if response.empty?
      puts 'Please enter a valid name'
      sleep 1
    elsif players.include?('player_name' => response, 'player_hands' => [{ 'cards' => [], 'status' => 'live' }])
      puts 'Name has already been taken; please choose another'
      sleep 1
    else
      players << { 'player_name' => response, 'player_hands' => [{ 'cards' => [], 'status' => 'live' }] }
      unnamed_players -= 1
      player_num += 1
      break
    end
  end
end

# gameplay

loop do
  # Initialize Deck and hands
  remaining_deck = []
  remaining_deck.replace(FULL_DECK)
  remaining_deck.shuffle!

  players.each { |player| player['player_hands'].replace([{ 'cards' => [], 'status' => 'live' }]) }
  dealer_hand.replace('cards' => [], 'status' => 'live')

  system "clear"
  if players.length > 1
    puts "Ok players! Let's begin"
  else
    puts "Ok #{players[0]['player_name']}! Let's begin"
  end
  puts ''
  puts "Dealing cards..."
  sleep 1.5
  system "clear"

  # start by dealing 2 cards to each.
  2.times do
    players.each { |player| deal(player['player_hands'][0], remaining_deck) }
    deal(dealer_hand, remaining_deck)
  end
  # check if dealer won
  #   if so display winner
  if value(dealer_hand) == 21
    puts 'Dealer got 21. Better luck next time!'
    puts ''
    display_end_state(players, dealer_hand)

  elsif !players.select { |player| value(player['player_hands'][0]) == 21 }.empty?
    players.select { |player| value(player['player_hands'][0]) == 21 }.each do |player|
      puts "#{player['player_name']} got 21! Congratulations!"
    end
    puts ''
    display_end_state(players, dealer_hand)
  else
    # display gamestate
    # (for each player)
    # for each hand
    #   display
    #   give valid options until hand not live
    # do until no live hands
    players.each do |player|
      player['player_hands'].each_with_index do |hand, i|
        if value(hand) == 21
          update_status(hand, '21')
        elsif value(hand) > 21
          update_status(hand, 'bust')
        end

        until hand['status'] != 'live'

          system "clear"
          puts "#{player['player_name']}'s turn:"
          puts ''
          display_game_state(dealer_hand, player, i, 'player')

          player_choice = valid_choice(hand, player_hands)

          # hit
          deal(hand, remaining_deck) if player_choice == '1'
          # stay
          update_status(hand, 'stayed') if player_choice == '2'
          # split -  modifies object being iterated over! This is intentional **********
          player['player_hands'] << { 'cards' => [hand['cards'].pop], 'status' => 'live' } if player_choice == '3'

          # check for 21 or bust and update appropriately
          if value(hand) == 21
            update_status(hand, '21')
          elsif value(hand) > 21
            update_status(hand, 'bust')
          end
        end
      end
      system "clear"
      puts "#{player['player_name']}'s turn:"
      puts ''
      display_game_state(dealer_hand, player, 0, 'player')
      sleep 1.5
    end

    # Dealer's turn

    system "clear"
    puts 'Revealing Dealer\'s cards...'
    puts ''
    display_game_state(dealer_hand, players.last, 0, 'player')
    sleep 2.5

    system "clear"
    puts 'Dealer\'s turn:'
    puts ''
    display_game_state(dealer_hand, players.last, 0, 'dealer')

    until dealer_hand['status'] != 'live' || all_same_status?(players, 'bust')
      sleep 1.5
      system "clear"

      case value(dealer_hand)
      when 0..16
        puts 'Dealer hits!'
        puts ''
        display_game_state(dealer_hand, players.last, 0, 'dealer')
        deal(dealer_hand, remaining_deck)
      when 17..20
        puts 'Dealer stays'
        puts ''
        display_game_state(dealer_hand, players.last, 0, 'dealer')
        update_status(dealer_hand, 'stayed')
      when 21
        puts 'Dealer gets 21!'
        puts ''
        display_game_state(dealer_hand, players.last, 0, 'dealer')
        update_status(dealer_hand, '21')
      else
        puts 'Dealer busts!'
        puts ''
        display_game_state(dealer_hand, players.last, 0, 'dealer')
        update_status(dealer_hand, 'bust')
      end
    end

    sleep 2
    system "clear"

    # Report results
    puts 'Results of game:'
    puts ''
    display_end_state(players, dealer_hand)
  end
  # Play again?
  3.times { puts '' }
  puts 'Would you like to play again?  y) yes   press any other key to exit'
  response = gets.chomp

  break unless response.downcase == 'y'
end

system "clear"
3.times { puts '' }
if players.length > 1
  puts "Bye everyone! Thank you for playing!"
else
  puts "Bye #{players[0]['player_name']}! Thank you for playing!"
end
3.times { puts '' }
