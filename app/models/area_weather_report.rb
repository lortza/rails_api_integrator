class AreaWeatherReportBase

  def self.get_report_data(state, city)
    weather_report = {
      current_city: Weather.get_weather_data(state, city),
      nearby_cities: related_cities_weather(state, city, 'nearby'),
      major_cities: related_cities_weather(state, city, 'major')
    }

    self.new(weather_report)
  end

  private

  def self.related_cities_weather(state, city, type)
    qty_cities = 3
    self.related_cities(state, city, type).map { |c| Weather.get_weather_data(c.state, c.city) }.compact[0...qty_cities]
  end

  def self.related_cities(state, city, type)
    GeoLocation.send("get_#{type}_cities", state, city)
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
