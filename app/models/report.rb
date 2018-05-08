class Report

  def initialize(state, city)
    @state = state
    @city = city
    @weather = set_weather_report(city, state)
    @articles = get_articles
    @events = get_events
    @photos = get_photos
  end



  def set_weather_report(city, state)
    weather_report = {
      current_city: get_weather(city, state),
      nearby_cities: []
    }

    nearby_cities = get_nearby_cities

    nearby_cities.each do |nc|
      weather_report[:nearby_cities] << get_weather(nc[:city], nc[:state])
    end

    weather_report
  end

  def get_nearby_cities
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

    cities_response = HTTParty.get("#{base_url}/#{city_id}/nearbyCities?distanceunit=mi&limit=#{qty}&radius=#{mile_radius}", headers: {
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

  def get_weather(city, state)
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

  def get_articles
    response = HTTParty.get("http://api.nytimes.com/svc/semantic/v2/concept/search.json?query=#{@city}, #{@state}&fields=article_list&api-key=#{ENV['NYT_API_KEY']}")
    response['results'].map do |result|
      {
        title: result['article_list']['results'][0]['title'],
        url: result['article_list']['results'][0]['url']
      } unless result['article_list']['results'] == []
    end
  end

   def get_events
    key =  ENV['EVENTS_API_KEY']
    response = HTTParty.get("http://api.eventful.com/json/events/search?app_key=#{ENV['EVENTS_API_KEY']}&l=#{@city}, #{@state}&t=Next+30+Days")
    parsed = JSON.parse(response)

    parsed['events']['event'].map do |event|
      {
        name: event['title'],
        date: event['start_time'],
        url: event['url'],
        venue: event['venue_name'],
        venue_url: event['venue_url']
      }
    end
  end

  def get_photos
    response = HTTParty.get("https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=#{ENV['PHOTO_API_KEY']}&text=#{@city}&format=json")
    response = response.gsub('jsonFlickrApi(', '')
    response = response[0..-2]
    parsed = JSON.parse(response)

    parsed['photos']['photo'].map do |pic|
      {
        author: pic['owner'],
        caption: pic['title'],
        url: "https://farm#{pic['farm']}.staticflickr.com/#{pic['server']}/#{pic['id']}_#{pic['secret']}.jpg"
      }
    end
  end


end
