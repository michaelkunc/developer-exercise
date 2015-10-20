require_relative 'blackjack'
require 'test/unit'

class CardTest < Test::Unit::TestCase
  def setup
    @card = Card.new(:hearts, :ten, 10)
  end

  def test_card_suite_is_correct
    assert_equal @card.suite, :hearts
  end

  def test_card_name_is_correct
    assert_equal @card.name, :ten
  end
  def test_card_value_is_correct
    assert_equal @card.value, 10
  end
end

class DeckTest < Test::Unit::TestCase
  def setup
    @deck = Deck.new
  end

  def test_new_deck_has_52_playable_cards
    assert_equal @deck.playable_cards.size, 52
  end

  def test_dealt_card_should_not_be_included_in_playable_cards
    card = @deck.deal_card
    refute(@deck.playable_cards.include?(card))
  end

  def test_shuffled_deck_has_52_playable_cards
    @deck.shuffle
    assert_equal @deck.playable_cards.size, 52
  end

  class GameTest < Test::Unit::TestCase
    def setup
      @game = Game.new
    end

    def test_game_player_has_a_hand
      assert_equal @game.player_hand.class, Hand
    end

    def test_game_dealer_has_a_hand
      assert_equal @game.dealer_hand.class, Hand
    end

    def test_game_should_have_a_deck
      assert_equal @game.deck.class, Deck
    end

    def test_get_count
      @game.player_hand.cards = [Card.new(:hearts, :ten, 10), Card.new(:spades, :ten, 10)]
      assert_equal @game.get_count(@game.player_hand), 20
    end

    def test_is_bust?
      @game.dealer_hand.cards = [Card.new(:hearts, :three, 3), Card.new(:spades, :six, 6)]
      assert_equal @game.bust?(@game.player_hand), false
    end

    def test_blackjack?
      assert_equal @game.blackjack?(@game.player_hand), false
    end

    def test_dealer_hit
      assert_equal @game.dealer_hit?, true
    end

    def test_inital_deal
      @game.initial_deal
      assert_equal @game.player_hand.cards.length, 2
    end

    def test_hit_me
      @game.hit_me(@game.player_hand)
      assert_equal @game.player_hand.cards.length, 1
    end

  end
end