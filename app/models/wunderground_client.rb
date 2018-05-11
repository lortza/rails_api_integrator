class WundergroundClient
  # Weather Underground API
  # Docs: https://www.wunderground.com/weather/api/d/docs
  # Sample endpoint: http://api.wunderground.com/api/#{API_KEY}/forecast/q/CA/San_Francisco.json

  include HTTParty
  base_uri "http://api.wunderground.com/api/#{ENV['WU_API_KEY']}"

  private

  def self.snake_case(str)
    str.strip.gsub(' ', '_')
  end
end
