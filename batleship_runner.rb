# require './lib/card'
# require './lib/deck'
# require './lib/round'
# require './lib/turn'
# require './lib/card_generator'
#
# card1 = Card.new("What is larger?  A llama or an alpaca? ", "Llama", :Animals)
# card2 = Card.new("Who paints happy trees?", "Bob Ross", :Pop_Culture)
# card3 = Card.new("How many chains are in a furlong?", "10", :Science)
# card4 = Card.new("How many grams are in a Kilogram?", "1000", :Science)
#
# # cards = [card1, card2, card3, card4]
# filename = "cards.txt"
# cards = CardGenerator.new(filename).cards
#
# deck = Deck.new(cards)
# round = Round.new(deck)
# round.


require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'


game = Game.new
game.start
