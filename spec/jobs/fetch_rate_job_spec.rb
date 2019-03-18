require 'rails_helper'

RSpec.describe FetchRateJob, type: :job do
  describe "#perform_later" do
    it "fetch a rate" do
      ActiveJob::Base.queue_adapter = :test
      expect {
        FetchRateJob.perform_later
      }.to enqueue_job
    end
  end
end
