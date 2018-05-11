class AreaWeatherReportBase
  def self.find(state, city)
    weather_report = {
      current_city: Weather.find(state, city),
      nearby_cities: nearby_city_weather(state, city)
    }

    self.new(weather_report)
  end

  private

  def self.nearby_city_weather(state, city)
    nearby_cities(state, city).map { |nc| Weather.find(nc[:state], nc[:city]) }
  end

  def self.nearby_cities(state, city)
    @nearby_cities ||= GeoLocation.get_nearby_cities(city, state)
  end
end

class AreaWeatherReport < AreaWeatherReportBase
  attr_reader :nearby_cities
  # Delegate moves all of the current_city info out into the WeatherReport object
  delegate :state, :city, :local_time, :description, :temperature, to: :@current_city

  def initialize(attrs)
    @current_city = attrs[:current_city]
    @nearby_cities = attrs[:nearby_cities]
  end
end
