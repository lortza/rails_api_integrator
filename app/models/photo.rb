class Photo

  # flickr Photo API
  # Docs: https://www.flickr.com/services/api/flickr.photos.search.html
  # Sample Image URL: "https://farm#{FARM_ID}.staticflickr.com/#{SERVER_ID}/#{PIC_ID}_#{PIC_SECRET}.jpg"

   def self.get_photos(city)
    puts "Finding Photos that mention #{city}"

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
