class GeoLocation

  # GeoDB API
  # Docs: http://geodb-city-api.wirefreethought.com/api-reference/find-nearby-cities-for-city-api
  # Docs: https://rapidapi.com/wirefreethought/api/GeoDB/functions/Cities%20Near%20City

  BASE_URL = "https://wft-geo-db.p.mashape.com/v1/geo/cities"

  def self.get_nearby_cities(state, city)
    puts "Getting Nearby Cities"

    qty_cities = 6
    mile_radius = 100

    city_id = self.get_current_city_id(state, city)

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

  def self.get_current_city_id(state, city)
    city_response = HTTParty.get(
      "#{BASE_URL}?namePrefix=#{city}&countryCodes=US", headers: {
          "X-Mashape-Key" => ENV['GEO_API_KEY'],
          "X-Mashape-Host" => ENV['GEO_API_HOST']
        })
    city_response['data'][0]['id']
  end

end
