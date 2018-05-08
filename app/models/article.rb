class Article

  # New York Times API
  # Docs: https://developer.nytimes.com/

  def self.get_articles(city, state)
    puts "Fetching Articles about #{city}, #{state}"

    response = HTTParty.get("http://api.nytimes.com/svc/semantic/v2/concept/search.json?query=#{city}, #{state}&fields=article_list&api-key=#{ENV['NYT_API_KEY']}")

    self.build_records(response)
  end

  private

  def self.build_records(response)
    response['results'].map do |result|
      {
        title: result['article_list']['results'][0]['title'],
        url: result['article_list']['results'][0]['url']
      } unless result['article_list']['results'] == []
    end
  end

end
