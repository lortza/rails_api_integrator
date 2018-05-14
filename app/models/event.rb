class Event

  # Eventful API
  # Docs: http://api.eventful.com/docs
  # Sample Endpoint: http://api.eventful.com/json/events/search?app_key=API_KEY&l=denver&t=Next+30+Days


  def self.get_events(state, city)
    puts "Fetching Events near #{city}, #{state}"

    response = HTTParty.get("http://api.eventful.com/json/events/search?app_key=#{ENV['EVENTS_API_KEY']}&l=#{city}, #{state}&t=Next+30+Days")

    formatted_response = JSON.parse(response)

    self.build_records(formatted_response)
  end

  private

  def self.build_records(response)
    response['events']['event'].map do |e|
      event = {
        id: e['id'],
        name: e['title'],
        date: e['start_time'],
        url: e['url'],
        venue: e['venue_name'],
        venue_url: e['venue_url']
      }
      if e['image']
        event[:image_url] = e['image']['medium']['url']
      else
        event[:image_url] = 'https://www.shareicon.net/data/128x128/2016/04/14/749705_music_512x512.png'
      end
      event
    end
  end

end
