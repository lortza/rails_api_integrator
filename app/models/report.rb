class Report

  def initialize(state, city)
    @state = state.upcase
    @city = city.titleize
    @weather = Weather.set_weather_report(@city, @state)
    @articles = Article.get_articles(@city, @state)
    @events = Event.get_events(@city, @state)
    @photos = Photo.get_photos(@city)
  end

end
