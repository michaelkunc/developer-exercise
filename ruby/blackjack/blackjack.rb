class Card
  attr_accessor :suite, :name, :value

  def initialize(suite, name, value)
    @suite, @name, @value = suite, name, value
  end
end

class Deck
  attr_accessor :playable_cards
  SUITES = [:hearts, :diamonds, :spades, :clubs]
  NAME_VALUES = {
    :two   => 2,
    :three => 3,
    :four  => 4,
    :five  => 5,
    :six   => 6,
    :seven => 7,
    :eight => 8,
    :nine  => 9,
    :ten   => 10,
    :jack  => 10,
    :queen => 10,
    :king  => 10,
    :ace   => 1}

  def initialize
    shuffle
  end

  def deal_card
    random = rand(@playable_cards.size)
    @playable_cards.delete_at(random)
  end

  def shuffle
    @playable_cards = []
    SUITES.each do |suite|
      NAME_VALUES.each do |name, value|
        @playable_cards << Card.new(suite, name, value)
      end
    end
  end
end

class Hand
  attr_accessor :cards

  def initialize
    @cards = []
  end
end

module Messages
  def self.dealer_show_card(card)
    puts "The dealer is showing #{card.name} of #{card.suite}"
  end

  def self.ask_player
    puts "Do you want another card? Y or N"
    input = gets.chomp!
    if ['Y', 'N'].include?(input)
      input
    else
      ask_player
    end
  end

  def self.welcome
    puts 'Welcome to Blackjack'
  end

  def self.player_cards(first_card, second_card)
    puts "you have a #{first_card.name} of #{first_card.suite} and a #{second_card.name} of #{second_card.suite}"
  end

  def self.show_hit_card(card)
    puts "The card is #{card.name} of #{card.suite}"
  end

  def self.bust
    puts "You have gone bust"
  end
end

class Game
  attr_reader :players, :player_hand, :dealer_hand, :deck
  include Messages
  def initialize
    @player_hand = Hand.new
    @dealer_hand = Hand.new
    # @players = [@player, @dealer]
    @deck = Deck.new
    @winner = nil
  end

  def play_game
    Messages.welcome
    initial_deal
    Messages.player_cards(@player_hand.cards[0], @player_hand.cards[1])
    player_round
  end

  def initial_deal
    2.times do
    @player_hand.cards << @deck.deal_card
    @dealer_hand.cards << @deck.deal_card
    end
    Messages.dealer_show_card(@dealer_hand.cards[1])
  end

  def player_round
    if @winner == nil
      if Messages.ask_player == 'N'
        dealer_round
      else
        hit_me(@player_hand)
        @winner = @dealer_hand if bust?(@player_hand)
        @winner = @player_hand if blackjack?(@player_hand)
      end
      player_round
    end
  end

  def dealer_round
    if @winner =! nil
      if get_count(@dealer_hand) < 17
        hit_me(@dealer_hand)
        @winner = @player_hand if bust?(@dealer_hand)
        @winner = @dealer_hand if blackjack?(@dealer_hand)
        dealer_round
      end
    end
  end

  def hit_me(hand)
    hand.cards << @deck.deal_card
    Messages.show_hit_card(hand.cards[-1])
  end

  def get_count(hand)
    hand.cards.inject(0) { |sum, card| sum + card.value }
  end

  def bust?(hand)
    get_count(hand) > 21
  end

  def blackjack?(hand)
    if @player_hand.cards.any? {|card| card.name == :ace}
      get_count(hand) - 10 == 21
    end
    get_count(hand) == 21
  end

  def dealer_hit?
    get_count(@dealer_hand) < 17
  end

end
