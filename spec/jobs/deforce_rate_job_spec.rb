require 'rails_helper'

RSpec.describe DeforceRateJob, type: :job do
  describe "#perform_later" do
    it "fetch a rate" do
      ActiveJob::Base.queue_adapter = :test
      expect {
        DeforceRateJob.set(wait_until: Time.current + 1.minute).perform_later
      }.to enqueue_job
    end
  end
end
