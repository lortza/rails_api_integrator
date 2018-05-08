class Weather

  # Weather Underground API
  # Docs: https://www.wunderground.com/weather/api/d/docs
  # Sample endpoint: http://api.wunderground.com/api/#{API_KEY}/forecast/q/CA/San_Francisco.json

  def self.set_weather_report(city, state)
    puts "Building Weather Report"

    weather_report = {
      current_city: self.get_weather(city, state),
      nearby_cities: []
    }

    nearby_cities = GeoLocation.get_nearby_cities(city, state)

    nearby_cities.each do |nc|
      weather_report[:nearby_cities] << get_weather(nc[:city], nc[:state])
    end

    weather_report
  end


  private

  def self.get_weather(city, state)
    stripped_city = city.strip.gsub(' ', '_')
    response = HTTParty.get("http://api.wunderground.com/api/#{ENV["WU_API_KEY"]}/conditions/q/#{state}/#{stripped_city}.json")
    {
      city: city,
      state: state,
      local_time: response['current_observation']['observation_time_rfc822'],
      description: response['current_observation']['weather'],
      temperature: response['current_observation']['temperature_string']
    }
  end


end
