class Report

  attr_reader :id, :state, :city, :area_weather, :articles, :events, :photos

  def initialize(state, city)
    @id = Time.now
    @state = state.upcase
    @city = city.titleize
  end

  def area_weather
    @area_weather ||= AreaWeatherReport.get_report_data(@state, @city)
  end

  def articles
    @articles ||= Article.get_articles(@city, @state)
  end

  def events
    # @events ||= Event.get_events(@city, @state)
  end

  def photos
    # @photos ||= Photo.get_photos(@city)
  end
end
