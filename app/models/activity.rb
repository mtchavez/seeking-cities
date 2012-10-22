class Activity

  def self.index(&block)
    BW::HTTP.get('http://seekingcities.com/?json=get_tag_index') do |response|
      result_data = BW::JSON.parse(response.body.to_str)
      block.call result_data['tags'].dup || []
    end
  end

end
