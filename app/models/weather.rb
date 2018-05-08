class Weather


  def self.set_weather_report(city, state)
    weather_report = {
      current_city: self.get_weather(city, state),
      nearby_cities: []
    }

    nearby_cities = self.get_nearby_cities

    nearby_cities.each do |nc|
      weather_report[:nearby_cities] << get_weather(nc[:city], nc[:state])
    end

    weather_report
  end


  # private

  def self.get_nearby_cities
    qty = 2
    mile_radius = 50
    base_url = "https://wft-geo-db.p.mashape.com/v1/geo/cities"

    # Find the input City's id
    city_response = HTTParty.get(
      "#{base_url}?namePrefix=#{@city}", headers: {
          "X-Mashape-Key" => ENV['GEO_API_KEY'],
          "X-Mashape-Host" => ENV['GEO_API_HOST']
        })
    city_id = city_response['data'][0]['id']

    built_url = "#{base_url}/#{city_id}/nearbyCities?distanceunit=mi&limit=#{qty}&radius=#{mile_radius}"

    cities_response = HTTParty.get(built_url, headers: {
        "X-Mashape-Key" => ENV['GEO_API_KEY'],
        "X-Mashape-Host" => ENV['GEO_API_HOST']
      })

    cities_response['data'].map do |c|
      {
        city: c['city'],
        state: c['regionCode'],
        id: c['id']
      }
    end
  end

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
