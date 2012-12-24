class Post

  POST_ATTRS = [:id, :thumbnail, :exerpt, :title, :tags, :type, :attachments, :slug, :categories, :author, :content]
  POST_ATTRS.each { |prop| attr_accessor prop }

  def self.from_category(category, &block)
    BW::HTTP.get("http://seekingcities.com/?json=get_category_posts&id=#{category.id}") do |response|
      result_data = BW::JSON.parse(response.body.to_str)
      posts = result_data['posts'] || []
      block.call posts.map { |post| Post.new post }
    end
  end

  def self.from_tag(tag, &block)
    BW::HTTP.get("http://seekingcities.com/?json=get_tag_posts&id=#{tag.id}") do |response|
      result_data = BW::JSON.parse(response.body.to_str)
      posts = result_data['posts'] || []
      block.call posts.map { |post| Post.new post }
    end
  end

  def find(&block)
    BW::HTTP.get("http://seekingcities.com/?json=get_post&id=#{id}") do |response|
      result_data = BW::JSON.parse(response.body.to_str)
      post = result_data['post'] || {}
      block.call Post.new post
    end
  end

  def initialize(attrs = {})
    attrs.each do |key, value|
      self.send("#{key.to_s}=", value) if POST_ATTRS.member? key.to_sym
    end
  end

  

end
