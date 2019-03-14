class ForcedRatesController < ApplicationController
  def new
    @forced_rate = ForcedRate.last || ForcedRate.new
    # FetchRateJob.perform_later
  end

  def create
    ForcedRate.create(value: permit_params[:value], expires_at: permit_params[:expires_at])
    render :new
  end

  private

  def permit_params
    params.require(:forced_rate).permit(:value, :expires_at)
  end
end
