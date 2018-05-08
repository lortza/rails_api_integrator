class GeoLocation

  BASE_URL = "https://wft-geo-db.p.mashape.com/v1/geo/cities"

  def self.get_nearby_cities(city, state)
    qty_cities = 2
    mile_radius = 50

    city_id = self.get_current_city_id(city, state)

    built_url = "#{BASE_URL}/#{city_id}/nearbyCities?distanceunit=mi&limit=#{qty_cities}&radius=#{mile_radius}"

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


  private

  def self.get_current_city_id(city, state)
    city_response = HTTParty.get(
      "#{BASE_URL}?namePrefix=#{city}&countryCodes=US", headers: {
          "X-Mashape-Key" => ENV['GEO_API_KEY'],
          "X-Mashape-Host" => ENV['GEO_API_HOST']
        })
    city_response['data'][0]['id']
  end

end
