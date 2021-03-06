class Table

	attr_reader :players, :board, :hands, :pot, :button, :active_players, :sb, :bb, :action

	def initialize(num_of_players)
		@players = []
		num_of_players.times { @players << Player.new(@players.length+1, 1000) }
		@board = []
		@pot = 0
		@button = rand(1..@players.length)
		@hands = []
	end

	def community_cards(card)
		@board << card
	end

	#rotate is pretty cool, think this is the right way, though I don't yet know
	#how the each loop will interact with all the intermediary decisions/actions
	#the condition means to assure that only non-folded players get to make decisions
	#SAME CONDITION WILL NEED TO BE ADDED IN SHOWDOWN, probably other places too
	def action
		@players.rotate(@button + 1).each do |player|
			if player.hole_cards.count == 2
				hand = player.combine(@board)
				if player.decision(hand, @pot) == 'Call'
					@pot += 100
				elsif player.decision(hand, @pot) == 'Raise'
					self.bet(300)
				end
			end
		end
	end

	def small_blind(level)
		@sb = (self.blinds_table[level]) / 2
		@players[@button + 1].ante(@sb)
		self.bet(sb)
	end

	def big_blind(level)
		@bb = (self.blinds_table[level])
		@players[@button + 2].ante(@bb)
		self.bet(bb)
	end

	def bet(raise)
		@pot += raise
	end

	def showdown
		@hands = []
		winner = []
		@players.each do |player|
			@hands << player.combine(@board)
		end
		@hands.each do |hand, player|
			winner << "Player #{hand.player}: #{Evaluator.make_best(hand)}"
		end
		@players.each do |player|
			puts "---------"
			player.hole_cards.each do |card|
				puts "#{player.seat}: #{card.rank} #{card.suit}"
			end
		end
		@board.each do |card|
			puts "#{card.rank} #{card.suit}"
		end
		puts winner
		return winner
	end

	def active_players
		@players.select do |player| 
			player.hole_cards.count == 2
		end
	end

	def clear_board
		@board = []
	end

	def empty_pot
		@pot = 0
	end

	def move_button
		@button += 1
		if @button > @players.length
			@button = 1
		end
	end

	def blinds_table
		@blinds_table = { 1 => 50, 2 => 100, 3 => 200, 4 => 400 }
	end

## need to find a way to do a clock or hand counter to increment blinds
	def blinds(level)
		self.small_blind(level)
		self.big_blind(level)
	end
end