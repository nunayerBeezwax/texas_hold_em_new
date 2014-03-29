class Brain

	# attr_reader :situation

	# def initialize
	# end

	# def situation
	# 	chips = self.chips
	# 	pot = pot.chips
	# 	position = self.position
	# 	hand = hand.quality(including current and draw percent)
	# 	action = incoming(raise(re-raise?))
	# 	players = players in hand
	# 	pot_odds 
	# 	read_of_players_in_hand
	# end

	# def pot_odds
	# 	#computes 
	# end

	def draw(hand, deal)
		flush_draw = count_suit(hand)
		if flush_draw == 4 && deal == 'flop'
			return ['flush', 0.35]
		end
		# current cards available
		# place in hand (preflop, after turn, etc.)
		# percent of what card comes out next
		# chance of making hand
	end

	def count_suit(hand)
		suit_count = 0
		suits = %w{ H S C D }
		suits.each do |s|
			count = hand.hand.hand.count { |card| card.suit == s }
			if count > suit_count 
				suit_count = count
			end
		end
		suit_count
	end

	# def read
	# 	# accesses database info on player in question for a type
	# end

end