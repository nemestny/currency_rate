class ForcedRatesController < ApplicationController
  def new
    @forced_rate ||= ForcedRate.last || ForcedRate.new
  end

  def create
    @forced_rate = ForcedRate.new(value: permit_params[:value], 
                        expires_at: permit_params[:expires_at])

    if @forced_rate.valid?
      clear_previous
      shedule_deforce
      @forced_rate.save
      redirect_to admin_path, flash: { notice: "Rate forced!" }
    else
      flash[:error]= @forced_rate.errors.full_messages.join('. ')
      redirect_to admin_path
    end
  end

  private

  def permit_params
    params.require(:forced_rate).permit(:value, :expires_at)
  end

  def clear_previous
    ForcedRate.last.update_attributes(expires_at: Time.current) if ForcedRate.last
    Sidekiq::ScheduledSet.new.clear
  end

  def shedule_deforce
    DeforceRateJob.set(wait_until: @forced_rate.expires_at).perform_later
  end
end
