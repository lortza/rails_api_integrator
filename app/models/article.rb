class Article

  attr_reader :title, :url, :date

  def initialize(result)
    @title = result['article_list']['results'][0]['title']
    @url = result['article_list']['results'][0]['url']
    @date = result['article_list']['results'][0]['date']
  end

end
