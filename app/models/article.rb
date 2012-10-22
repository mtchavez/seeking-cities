class Article

  def self.index(&block)
    BW::HTTP.get('http://seekingcities.com/?json=get_recent_posts') do |response|
      result_data = BW::JSON.parse(response.body.to_str)
      block.call result_data['posts'].dup || []
    end
  end

  def initialize(attrs = {})
    
  end

end
