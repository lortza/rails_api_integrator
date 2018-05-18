class GeoLocation

  # GeoDB API
  # Docs: http://geodb-city-api.wirefreethought.com/api-reference/find-nearby-cities-for-city-api
  # Docs: https://rapidapi.com/wirefreethought/api/GeoDB/functions/Cities%20Near%20City

  BASE_URL = "https://wft-geo-db.p.mashape.com/v1/geo"
  COUNTRY_CODE = 'US'


  def self.get_major_cities(state, city)
    puts "Getting Major Cities in #{state}"

    qty_cities = 4

    built_url = "#{BASE_URL}/countries/#{COUNTRY_CODE}/regions/#{state}/cities?sort=-population&offset=0&limit=#{qty_cities}"

    cities_response = HTTParty.get(
      built_url, headers: {
          "X-Mashape-Key" => ENV['GEO_API_KEY'],
          "X-Mashape-Host" => ENV['GEO_API_HOST']
        })

    cities = self.exclude_current_city(cities_response['data'], city)

    cities.shuffle.map do |c|
      self.new({
        city: c['city'],
        state: state,
        id: c['id']
      })
    end
  end


  def self.get_nearby_cities(state, city)
    puts "Getting Nearby Cities for #{city}, #{state}"

    qty_cities = 6
    mile_radius = 100

    city_id = self.get_current_city_id(state, city)

    built_url = "#{BASE_URL}/cities/#{city_id}/nearbyCities?distanceunit=mi&limit=#{qty_cities}&radius=#{mile_radius}"

    cities_response = HTTParty.get(built_url, headers: {
        "X-Mashape-Key" => ENV['GEO_API_KEY'],
        "X-Mashape-Host" => ENV['GEO_API_HOST']
      })

    cities = self.exclude_current_city(cities_response['data'], city)

    cities.shuffle.map do |c|
      self.new({
        city: c['city'],
        state: c['regionCode'],
        id: c['id']
      })
    end
  end


  attr_reader :city, :state, :id

  def initialize(attrs)
    @city = attrs[:city]
    @state = attrs[:state]
    @id = attrs[:id]
  end


  private

  def self.exclude_current_city(response, city)
    response.select {|c| c['city'] != city }
  end


  def self.get_current_city_id(state, city)
    cities_response = HTTParty.get(
      "#{BASE_URL}/cities?namePrefix=#{city}&countryCode=#{COUNTRY_CODE}", headers: {
          "X-Mashape-Key" => ENV['GEO_API_KEY'],
          "X-Mashape-Host" => ENV['GEO_API_HOST']
        })
    us_cities = cities_response['data'].select {|c| c['countryCode'] == COUNTRY_CODE }
    city_in_desired_state = us_cities.select {|c| c['regionCode'] == state }[0]

    if city_in_desired_state
      city_in_desired_state['id']
    else
      self.get_biggest_city(state)['id']
    end
  end


  def self.get_biggest_city(state)
    cities_response = HTTParty.get(
      "#{BASE_URL}/countries/#{COUNTRY_CODE}/regions/#{state}/cities?sort=-population&offset=0&limit=1", headers: {
          "X-Mashape-Key" => ENV['GEO_API_KEY'],
          "X-Mashape-Host" => ENV['GEO_API_HOST']
        })
    cities_response['data'].first
  end
end
