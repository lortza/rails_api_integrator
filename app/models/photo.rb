class Photo

   def self.get_photos(city)
    response = HTTParty.get("https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=#{ENV['PHOTO_API_KEY']}&text=#{city}&format=json")

    formatted_response = self.format_response(response)

    self.build_records(formatted_response)
  end


  private

  def self.format_response(response)
    response = response.gsub('jsonFlickrApi(', '')
    response = response[0..-2]
    JSON.parse(response)
  end


  def self.build_records(response)
    response['photos']['photo'].map do |pic|
      {
        author: pic['owner'],
        caption: pic['title'],
        url: "https://farm#{pic['farm']}.staticflickr.com/#{pic['server']}/#{pic['id']}_#{pic['secret']}.jpg"
      }
    end
  end

end
