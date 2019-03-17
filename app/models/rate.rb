class Rate < ApplicationRecord

  after_create_commit {ActionCable.server.broadcast('rate', Rate.current)}

  def self.current
    forced = ForcedRate.last
    fetched = FetchedRate.last
    if forced && (forced.expires_at.utc > Time.now.utc)
      forced
    else
      fetched
    end
  end
end
