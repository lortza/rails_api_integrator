class Weather < WundergroundClient

  def self.find(state, city)
    response = self.get("/conditions/q/#{state}/#{snake_case(city)}.json")
    self.new(response)
  end

  attr_reader :city, :state, :local_time, :description, :temperature

  def initialize(response)
    @city = response['current_observation']['display_location']['city']
    @state = response['current_observation']['display_location']['state']
    @local_time = response['current_observation']['observation_time_rfc822']
    @description = response['current_observation']['weather']
    @temperature = response['current_observation']['temperature_string']
  end
end
