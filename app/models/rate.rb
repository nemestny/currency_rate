class Rate < ApplicationRecord

  after_create_commit {ActionCable.server.broadcast('rate', self.current)}

  def current
    if forced && (forced.expires_at.utc > Time.now.utc)
      forced
    else
      fetched
    end
  end

  private

  def forced
    ForcedRate.last
  end

  def fetched
    FetchedRate.last
  end
end
