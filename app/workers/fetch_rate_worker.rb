class FetchRateWorker < ApplicationJob
  include Sidekiq::Worker

  RATES_SOURCE_URL = 'https://www.cbr-xml-daily.ru/daily.xml'
  CURRENCY_CODE = 'USD'

  def perform(*args)
    get_rate
    create_rate
    return if @rate.value == FetchedRate.last&.value 
    @rate.save
  end

  private

  def get_rate
    @res = Net::HTTP.get(URI(RATES_SOURCE_URL))

    @params = Hash.from_xml(@res).dig('ValCurs', 'Valute').find do |item|
      item['CharCode'] == CURRENCY_CODE
    end
  end

  def create_rate
    value = @params['Value'].tr(',','.').to_f
    nominal = @params['Nominal'].to_i
    @rate = FetchedRate.new(value: value*nominal)
  end
end