class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer) ->

  replay: -> @trigger 'replay'

  hit: -> 
    @add(@deck.pop()).last()
    if @scores()[0] > 21
      @bust()

  blackjack: ->
    if @scores()[0] == 21
      @trigger 'blackjack'
      # $('.stand-button').hide()
      # $('.hit-button').hide()

  bust: -> @trigger 'bust'

  stand: -> 
    @trigger 'stand'
    (@get 'dealerHand').blackjack()

  lose: -> @trigger 'lose'

  win: -> @trigger 'win'

  tie: -> @trigger 'tie'

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    hasAce = @reduce (memo, card) ->
      memo or card.get('value') is 1
    , false
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    if hasAce and (score + 10 <= 21) then [score + 10] else [score]
