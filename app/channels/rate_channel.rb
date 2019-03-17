class RateChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'rate'
  end

  def send_rate(*args)
    ActionCable.server.broadcast('rate',Rate.current)
  end
end
