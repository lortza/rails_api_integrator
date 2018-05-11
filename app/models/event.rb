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
    response['events']['event'].map do |event|
      {
        name: event['title'],
        date: event['start_time'],
        url: event['url'],
        venue: event['venue_name'],
        venue_url: event['venue_url']
      }
    end
  end

end
