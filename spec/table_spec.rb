require 'spec_helper'

describe 'Table' do
	describe '#initialize' do
		it 'sets up a new table instance with X number of players, and an empty array for community cards' do
			test_table = Table.new(9)
			test_table.players.length.should eq 9
			test_table.should be_an_instance_of Table
			test_table.players[0].should be_an_instance_of Player
			test_table.players[2].chips.should eq 1000
			test_table.board.should eq []
		end
	end

	describe '#showdown' do
		it 'collects all remaining players hands into an array' do
			test_game = Game.new
			test_game.dealer.preflop
			test_game.dealer.flop
			test_game.dealer.turn
			test_game.dealer.river
			test_game.table.showdown
			test_game.table.showdown.length.should eq 9
		end
	end

	describe '#pot' do
		it 'starts at zero, and goes up as people deposit chips' do
			test_game = Game.new
			test_game.table.pot.should eq 0
			test_game.table.bet(test_game.table.players[3].raise(100))
			test_game.table.pot.should eq 100
			test_game.table.players[3].chips.should eq 900
			test_game.table.bet(test_game.table.players[5].raise(225))
			test_game.table.pot.should eq 325
			test_game.table.players[5].chips.should eq 775
		end
	end

	describe '#button' do
		it 'starts at a random place on a table and increments(wrapping) each hand' do
			test_game = Game.new
			test_game.table.button.should be_between(1, 9)
		end
	end	

	describe '#action' do
		it 'beginning with button+1, asks each player still in the hand to make a decision' do
			test_game = Game.new
			test_game.dealer.preflop
			test_game.table.action
			puts test_game.table.pot
			test_game.table.players.each { |p| p.hole_cards.each {|c| print "#{c.rank}#{c.suit}" } }
			test_game.table.pot.should > 0
		end
	end

	describe '#active_players' do
		it 'holds a temporary count of non-folded players at a given time' do
			test_game = Game.new
			test_game.dealer.preflop
			test_game.table.action
			test_game.table.active_players.count.should < 7
		end
	end
end