# frozen_string_literal: true

## Class of Rates
class Rate < ApplicationRecord
  validates :value, presence: true, numericality: true, format: { with: /\A\d{1,4}(.\d{0,4})?\z/ }

  after_create_commit { ActionCable.server.broadcast('rate', Rate.current) }

  def self.current
    forced = ForcedRate.last
    fetched = FetchedRate.last
    if forced && (forced.expires_at.utc > Time.now.utc) # or use Time.current?...
      forced
    else
      fetched
    end
  end
end
