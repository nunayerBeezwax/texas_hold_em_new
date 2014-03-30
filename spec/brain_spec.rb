require 'spec_helper'

describe Brain do
	describe '#draw' do
		it 'computes the odds of making a hand' do
			test_game = Game.new
			hole_card1 = Card.new('H', 10)
			hole_card2 = Card.new('H', 11)
			board_card1 = Card.new('H', 5)
			board_card2 = Card.new('H', 2)
			board_card3 = Card.new('C', 13)
			player = test_game.table.players[0]
			board = test_game.table.board
			player.hole_cards << hole_card1
			player.hole_cards << hole_card2
			board << board_card1
			board << board_card2
			board << board_card3
			hand = Hand.new(player.combine(board), player)
			player.brain.draw(hand, 'flop')
			player.brain.odds['flush'].should be_within(0.005).of(0.3496)
		end
	end
end