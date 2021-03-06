// Generated by CoffeeScript 1.6.2
var _ref,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

window.Hand = (function(_super) {
  __extends(Hand, _super);

  function Hand() {
    _ref = Hand.__super__.constructor.apply(this, arguments);
    return _ref;
  }

  Hand.prototype.model = Card;

  Hand.prototype.initialize = function(array, deck, isDealer) {
    this.deck = deck;
    this.isDealer = isDealer;
  };

  Hand.prototype.replay = function() {
    return this.trigger('replay');
  };

  Hand.prototype.hit = function() {
    this.add(this.deck.pop()).last();
    if (this.scores()[0] > 21) {
      return this.bust();
    }
  };

  Hand.prototype.blackjack = function() {
    if (this.scores()[0] === 21) {
      return this.trigger('blackjack');
    }
  };

  Hand.prototype.bust = function() {
    return this.trigger('bust');
  };

  Hand.prototype.stand = function() {
    this.trigger('stand');
    return (this.get('dealerHand')).blackjack();
  };

  Hand.prototype.lose = function() {
    return this.trigger('lose');
  };

  Hand.prototype.win = function() {
    return this.trigger('win');
  };

  Hand.prototype.tie = function() {
    return this.trigger('tie');
  };

  Hand.prototype.scores = function() {
    var hasAce, score;

    hasAce = this.reduce(function(memo, card) {
      return memo || card.get('value') === 1;
    }, false);
    score = this.reduce(function(score, card) {
      return score + (card.get('revealed') ? card.get('value') : 0);
    }, 0);
    if (hasAce && (score + 10 <= 21)) {
      return [score + 10];
    } else {
      return [score];
    }
  };

  return Hand;

})(Backbone.Collection);
