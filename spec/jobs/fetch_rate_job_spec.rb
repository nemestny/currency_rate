# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FetchRateJob, type: :job do
  describe '#perform_later' do
    it 'fetch a rate' do
      ActiveJob::Base.queue_adapter = :test
      expect do
        FetchRateJob.perform_later
      end.to enqueue_job
    end
  end
end
