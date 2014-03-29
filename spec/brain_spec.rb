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
			test_player = test_game.table.players[0]
			test_player.hole_cards << hole_card1
			test_player.hole_cards << hole_card2
			test_game.table.board << board_card1
			test_game.table.board << board_card2
			test_game.table.board << board_card3
			test_hand = Hand.new(test_player.combine(test_game.table.board), test_player)
			test_player.brain.draw(test_hand, 'flop').should eq ['flush', 0.35]
		end
	end
end