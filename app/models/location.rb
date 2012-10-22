class Location

  def self.index(&block)
    BW::HTTP.get('http://seekingcities.com/?json=get_category_index') do |response|
      result_data = BW::JSON.parse(response.body.to_str)
      block.call result_data['categories'].dup || []
    end
  end

end
