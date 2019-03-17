class ForcedRatesController < ApplicationController
  def new
    @forced_rate = ForcedRate.last || ForcedRate.new
    # FetchRateJob.perform_later
  end

  def create
    @forced_rate = ForcedRate.new(value: permit_params[:value], 
                        expires_at: permit_params[:expires_at])

    if @forced_rate.valid?
      clear_previous
      shedule_deforce
      @forced_rate.save
      # flash.now[:notice] = 'Forced Rate created'
      render :new
    else
      render :new
    end
  end

  private

  def permit_params
    params.require(:forced_rate).permit(:value, :expires_at)
  end

  def clear_previous
    ForcedRate.last.update_attributes(expires_at: Time.now)
    Sidekiq::ScheduledSet.new.clear
  end

  def shedule_deforce
    DeforceRateJob.set(wait_until: @forced_rate.expires_at).perform_later
  end
end
