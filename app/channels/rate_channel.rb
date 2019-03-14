class RateChannel < ApplicationCable::Channel
  def subscribed
    # forced = ForcedRate.last
    # if forced && forced.expires_at > Time.now
    #   rate = forced
    # else
    #   rate = FetchedRate.last
    # end
    # test = {value: 'test'}
    # stream_from test
    # rate = {value: 'deddd'}
    # RateChannel.broadcast_to 'rate', Rate.last
    stream_from 'rate'
  end

  def send_rate(*args)
    puts '+'*10
    ActionCable.server.broadcast('rate',Rate.last)
    puts '-'*10
  end
end
