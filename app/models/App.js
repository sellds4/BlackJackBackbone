// Generated by CoffeeScript 1.6.2
var _ref,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

window.App = (function(_super) {
  __extends(App, _super);

  function App() {
    _ref = App.__super__.constructor.apply(this, arguments);
    return _ref;
  }

  App.prototype.initialize = function() {
    var deck, nextCard,
      _this = this;

    nextCard = function() {
      if ((_this.get('dealerHand')).scores()[0] < 17) {
        return setTimeout((function() {
          (_this.get('dealerHand')).hit();
          return nextCard();
        }), 1000);
      } else {
        if ((_this.get('dealerHand')).scores()[0] > 21) {
          return (_this.get('playerHand')).win();
        } else if ((_this.get('dealerHand')).scores()[0] === (_this.get('playerHand')).scores()[0]) {
          return (_this.get('playerHand')).tie();
        } else if ((_this.get('dealerHand')).scores()[0] >= (_this.get('playerHand')).scores()[0]) {
          return (_this.get('playerHand')).lose();
        } else {
          return (_this.get('playerHand')).win();
        }
      }
    };
    this.set('deck', deck = new Deck());
    this.set('playerHand', deck.dealPlayer());
    this.set('dealerHand', deck.dealDealer());
    return (this.get('playerHand')).on('stand', function() {
      var playerScore;

      playerScore = (_this.get('playerHand')).scores()[0];
      (_this.get('dealerHand')).models[0].flip();
      return nextCard();
    });
  };

  return App;

})(Backbone.Model);
