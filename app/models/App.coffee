#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    nextCard = =>
      if (@get 'dealerHand').scores()[0] < 17
        setTimeout (=>
          (@get 'dealerHand').hit()
          nextCard()
          ), 1000
      else
        if (@get 'dealerHand').scores()[0] > 21
          (@get 'playerHand').win()
        else if (@get 'dealerHand').scores()[0] == (@get 'playerHand').scores()[0]
          (@get 'playerHand').tie()
        else if (@get 'dealerHand').scores()[0] >= (@get 'playerHand').scores()[0]
          (@get 'playerHand').lose()
        else
          (@get 'playerHand').win()
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    (@get 'playerHand').on 'stand', =>
      playerScore = (@get 'playerHand').scores()[0]
      (@get 'dealerHand').models[0].flip()
      nextCard()
