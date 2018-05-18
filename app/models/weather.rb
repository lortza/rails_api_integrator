class Weather < WundergroundClient

  def self.get_weather_data(state, city)
    response = self.get("/conditions/q/#{state}/#{snake_case(city)}.json")
    if response['current_observation']
      self.new(response)
    else
      puts "Wunderground data doesn't include #{city}, #{state}. Skipping."
    end
  end

  attr_reader :city, :state, :local_time, :description, :temperature

  def initialize(response)
    @city = response['current_observation']['display_location']['city']
    @state = response['current_observation']['display_location']['state']
    @local_time = response['current_observation']['observation_time_rfc822']
    @description = response['current_observation']['weather']
    @temperature = response['current_observation']['temp_f']
    @icon_url = response['current_observation']['icon_url']
  end
end
