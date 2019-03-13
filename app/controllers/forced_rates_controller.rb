class ForcedRatesController < ApplicationController
  def new
    FetchRateJob.perform_later
  end
end
