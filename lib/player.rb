class Player
	attr_reader :chips, :hole_cards, :name, :seat, :hand, :raise, :brain

	def initialize(seat, chips)
		@hole_cards = []
		@chips = chips
		@seat = seat
		@hand = []
		@brain = Brain.new
	end

	def get_card(card)
		@hole_cards << card
	end

	def combine(board)
		self.hole_cards.each { |card| @hand << card }
		board.each { |card| @hand << card }
		Hand.new(@hand, self)
	end

	def fold
		@hole_cards = []
	end

	def call(amount)
		@chips -= amount
	end

	def raise(amount)
		@chips -= amount
		@raise = amount 
	end

	def decision(board, pot)
		if board.length == 0
			preflop_decision
		elsif board.length == 3
			postflop_decision
		elsif board.length == 4
			turn_decision
		else
			river decision
		end
	end

	def preflop_decision
		self.hole_cards.each { |card| @hand << card }
		self.brain.preflop(@hand)
	end

end