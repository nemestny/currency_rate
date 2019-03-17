class DeforceRateJob < ApplicationJob
  queue_as :critical

  def perform(*args)
    rate = FetchedRate.last.dup
    return unless rate
    rate.save
  end
end
