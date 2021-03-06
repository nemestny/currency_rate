# frozen_string_literal: true

class RateChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'rate'
  end

  def send_rate(*_args)
    ActionCable.server.broadcast('rate', Rate.current)
  end
end
