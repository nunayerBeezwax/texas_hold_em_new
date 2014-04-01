require './lib/dealer'
require './lib/evaluator'
require './lib/game'
require './lib/deck'
require './lib/player'
require './lib/hand'
require './lib/table'
require './lib/card'
require './lib/brain'
require 'pry'

def main_menu
	puts "Poker: ", 
			 "Press 'N' to start a New Game"
	choice = gets.chomp.downcase
	case choice
	when 'n'
		new_game
	when 'x'
		exit
	else 
		puts "Invalid entry, please try again."
		main_menu
	end
end

def new_game
	game = Game.new
	user = game.table.players.sample
	puts "Press 'D' to deal"
	choice = gets.chomp.downcase
		case choice
		when 'd'
			game.dealer.preflop
		end
	puts "\nYour hole cards are:",
			 "----------------------"
	puts "#{game.table.players[0].hole_cards[0].rank} of #{game.table.players[0].hole_cards[0].suit}",
				"#{game.table.players[0].hole_cards[1].rank} of #{game.table.players[0].hole_cards[1].suit}",
			 "-------"
	game.table.action
	puts "Press 'C' to call"
	call = gets.chomp.downcase
		if call == 'C'
			user.call(100)
		else
			user.fold
		end
	puts "Press 'F' to see the flop:"
	choice = gets.chomp.downcase
		if choice == 'f'
			game.dealer.flop
		end
	puts "There are #{game.table.active_players.count} players still in the hand"
	puts "The pot is now #{game.table.pot}"
	puts "Your chip stack is #{user.chips}"
	puts "\nHere is the flop:",
			 "--------------------",
			 "#{game.table.board[0].rank} of #{game.table.board[0].suit}",
			 "#{game.table.board[1].rank} of #{game.table.board[1].suit}",
			 "#{game.table.board[2].rank} of #{game.table.board[2].suit}",
			 "-------"
	puts "Press 'T' to see the turn:"
	choice = gets.chomp.downcase
		if choice == 't'
			game.dealer.turn
		end
	puts "\nHere is the turn:",
			 "--------------------",
			 "#{game.table.board[0].rank} of #{game.table.board[0].suit}",
			 "#{game.table.board[1].rank} of #{game.table.board[1].suit}",
			 "#{game.table.board[2].rank} of #{game.table.board[2].suit}",
			 "#{game.table.board[3].rank} of #{game.table.board[3].suit}",
			 "-------"
	puts "Press 'R' to see the river:"
	choice = gets.chomp.downcase
		if choice == 'r'
			game.dealer.river
		end
	puts "\nHere is the river:",
			 "--------------------",
			 "#{game.table.board[0].rank} of #{game.table.board[0].suit}",
			 "#{game.table.board[1].rank} of #{game.table.board[1].suit}",
			 "#{game.table.board[2].rank} of #{game.table.board[2].suit}",
			 "#{game.table.board[3].rank} of #{game.table.board[3].suit}",
			 "#{game.table.board[4].rank} of #{game.table.board[4].suit}",
			 "-------"
	user_hand = user.combine(game.table.board)
	puts "You got a #{Evaluator.make_best(user_hand)}"
	game.table.active_players.each do |player|
		binding.pry
		puts "Player #{player.seat} got a #{Evaluator.make_best(player.hand)}"
	end
	main_menu
end

main_menu