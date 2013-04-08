class window.HandView extends Backbone.View

  className: 'hand'

  #todo: switch to mustache
  template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score"></span>)</h2>'
  
  events:
    "click .replay-button": -> @model.get('playerHand').replay()

  initialize: ->
    #TODO: why doesn't 'add' trigger 'change'?
    @collection.on 'change', => @render()
    @collection.on 'add', => @render()
    @render()
    @collection.on 'win', => 
      @$el.append "<div style=\"font-size:48px; color:green; postion:absolute\">PAY THE MAN!</div>"
      @$el.prepend "<div><button class=\"replay-button\">Replay?</button></div>"
      $('.buttons').hide()
    @collection.on 'tie', => 
      @$el.append "<div style=\"font-size:48px; color:blue; postion:absolute\">PUSH IT!</div>"
      @$el.prepend "<div><button class=\"replay-button\">Replay?</button></div>"
      $('.buttons').hide()
    @collection.on 'lose', => 
      @$el.append "<div style=\"font-size:48px; color:red; postion:absolute\">LOSE MUCH?</div>"
      @$el.prepend "<div><button class=\"replay-button\">Replay?</button></div>"
      $('.buttons').hide()
    @collection.on 'bust', => 
      @$el.append "<div style=\"font-size:48px; color:red; postion:absolute\">HELLA-BUSTED!!!</div>"
      @$el.prepend "<div><button class=\"replay-button\">Replay?</button></div>"
      $('.buttons').hide()
    @collection.on 'blackjack', =>
      @$el.append "<div style=\"font-size:48px; position:absolute\">BLACK JACK!</div>"
      @$el.prepend "<div><button class=\"replay-button\">Replay?</button></div>"
      $('buttons').hide()

  render: ->
    @$el.children().detach
    @$el.html(@template @collection).append @collection.map (card) -> new CardView(model: card).el
    @$('.score').text @collection.scores()[0]
