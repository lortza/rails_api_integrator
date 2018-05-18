class Article

  attr_reader :title, :url, :date

  def initialize(result)
    @title = result['article_list']['results'][0]['title']
    @url = result['article_list']['results'][0]['url']
    @date = to_datetime(result['article_list']['results'][0]['date'])
  end

  def to_datetime(str)
    DateTime.parse(str).to_s(:db)
  end

end
