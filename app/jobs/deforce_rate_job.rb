# frozen_string_literal: true

class DeforceRateJob < ApplicationJob
  queue_as :critical

  def perform(*_args)
    rate = FetchedRate.last.dup
    return unless rate

    rate.save
  end
end
