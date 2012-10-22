class Activity

  ACTIVITY_ATTRS = [:id, :slug, :title, :description, :post_count]
  ACTIVITY_ATTRS.each { |prop| attr_accessor prop }

  def self.index(&block)
    BW::HTTP.get('http://seekingcities.com/?json=get_tag_index') do |response|
      result_data = BW::JSON.parse(response.body.to_str)
      tags = result_data['tags'] || []
      block.call tags.map { |tag| Activity.new tag }
    end
  end

  def initialize(attrs = {})
    attrs.each do |key, value|
      self.send("#{key.to_s}=", value) if ACTIVITY_ATTRS.member? key.to_sym
    end
  end

end
