class RateChannel < ApplicationCable::Channel
  def subscribed
    forced = ForcedRate.last
    if forced && forced.expires_at > Time.now
      rate = forced
    else
      rate = FetchedRate.last
    end

    stream_from rate
  end
end
