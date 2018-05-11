class ArticleReport

  def self.get_report_data(state, city)
    response = NYTClient.semantic_search(state, city)
    self.new(response)
  end
  
  def initialize(response)
    @articles = build_records(response)
  end

  def build_records(response)
    response['results'].map do |result|
      Article.new(result) unless result['article_list']['results'] == []
    end.compact
  end

end
