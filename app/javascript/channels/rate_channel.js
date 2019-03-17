ActionCable = require('actioncable')
 
var cable = ActionCable.createConsumer()
 
cable.subscriptions.create('RateChannel', {
  connected: function() {
      return this.send_rate();
  },
  received: function(data) {
      console.log('[RateChannel]', data);
      return $("#rate_value").html(data["value"]);
  },
  send_rate: function() {
      return this.perform("send_rate", {
        sending_rate: $("main").data()
      });
  }
});