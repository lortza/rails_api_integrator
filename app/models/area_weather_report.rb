class AreaWeatherReportBase

  def self.get_report_data(state, city)
    weather_report = {
      current_city: Weather.get_weather_data(state, city),
      nearby_cities: city_weather(state, city, 'nearby'),
      major_cities: city_weather(state, city, 'major')
    }

    self.new(weather_report)
  end

  private

  def self.city_weather(state, city, type)
    send("#{type}_cities", state, city).map { |nc| Weather.get_weather_data(nc[:state], nc[:city]) }.compact[0..2]
  end

  def self.nearby_cities(state, city)
    @nearby_cities = GeoLocation.get_nearby_cities(state, city)
  end

  def self.major_cities(state, city)
    @major_cities = GeoLocation.get_major_cities(state, city)
  end
end

class AreaWeatherReport < AreaWeatherReportBase
  attr_reader :nearby_cities, :major_cities
  # Delegate moves all of the current_city info out into the AreaWeatherReport object
  delegate :state, :city, :local_time, :description, :temperature, to: :@current_city

  def initialize(attrs)
    @current_city = attrs[:current_city]
    @nearby_cities = attrs[:nearby_cities]
    @major_cities = attrs[:major_cities]
  end
end
