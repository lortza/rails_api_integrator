class NYTClient
  # New York Times API
  # Docs: https://developer.nytimes.com/

  include HTTParty
  base_uri "http://api.nytimes.com/svc"

  def self.semantic_search(state, city)
    puts "Fetching Articles about #{city}, #{state}"

    self.get("/semantic/v2/concept/search.json?api-key=#{ENV['NYT_API_KEY']}&query=#{city}, #{state}&fields=article_list")
  end

end
