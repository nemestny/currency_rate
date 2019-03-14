App.rate = App.cable.subscriptions.create "RateChannel",
  connected: ->
    @send_rate()

  received: (data) ->
    console.log('[sss]',data)
    $("#rate_value").html data["value"]
    # Called when there's incoming data on the websocket for this channel

  send_rate: ->
    # Вызывает `AppearanceChannel#appear(data)` на сервере.
    @perform("send_rate", sending_rate: $("main").data("appearing-on"))
