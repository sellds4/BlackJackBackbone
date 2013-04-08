class window.AppView extends Backbone.View

  template: _.template '
    <div class="buttons"><button class="hit-button">Hit</button><button class="stand-button">Stand</button></div>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    "click .hit-button": -> @model.get('playerHand').hit()
    "click .stand-button": -> 
      $('.stand-button').hide()
      $('.hit-button').hide()
      @model.get('playerHand').stand()
    "click .replay-button": ->
      window.location.reload()

  initialize: ->
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
    (@model.get 'playerHand').blackjack()
