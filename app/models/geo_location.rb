class GeoLocation

  # GeoDB API
  # Docs: http://geodb-city-api.wirefreethought.com/api-reference/find-nearby-cities-for-city-api
  # Docs: https://rapidapi.com/wirefreethought/api/GeoDB/functions/Cities%20Near%20City

  BASE_URL = "https://wft-geo-db.p.mashape.com/v1/geo"
  COUNTRY_CODE = 'US'

  def self.get_nearby_cities(state, city)
    puts "Getting Nearby Cities for #{city}, #{state}"

    cities_response = self.get_major_cities(state, city)

    cities_response.map do |c|
      {
        city: c['city'],
        state: c['regionCode'],
        id: c['id']
      }
    end
  end


  private

  def self.get_major_cities(state, city)
    puts "Getting Major Cities in #{state}"

    built_url = "#{BASE_URL}/countries/#{COUNTRY_CODE}/regions/#{state}/cities?sort=-population&offset=0&limit=6"

    cities_response = HTTParty.get(
      built_url, headers: {
          "X-Mashape-Key" => ENV['GEO_API_KEY'],
          "X-Mashape-Host" => ENV['GEO_API_HOST']
        })
    cities_excluding_current_city = cities_response['data'].select {|c| c['city'] != city }
    cities_excluding_current_city.each {|c| c['regionCode'] = state}
  end

end
