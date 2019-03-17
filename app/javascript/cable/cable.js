// console.log('Cable')
import App from "actioncable"

(function() {
  this.App || (this.App = {});

  App.cable = ActionCable.createConsumer();

}).call(this);