class Report

  attr_accessor :weather, :articles

  def initialize(state, city)
    @state = state
    @city = city
    @weather = get_weather
    @articles = get_articles
    @events = get_events
    @photos = get_photos
  end

  def get_weather
    city = @city.strip.gsub(' ', '_')
    response = HTTParty.get("http://api.wunderground.com/api/#{ENV["WU_API_KEY"]}/conditions/q/#{@state}/#{city}.json")
    {
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
