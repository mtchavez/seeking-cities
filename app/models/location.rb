class Location

  LOC_ATTRS = [:id, :slug, :title, :post_count]
  LOC_ATTRS.each { |prop| attr_accessor prop }

  def self.index(&block)
    BW::HTTP.get('http://seekingcities.com/?json=get_category_index') do |response|
      result_data = BW::JSON.parse(response.body.to_str)
      categories = result_data['categories'] || []
      
      block.call categories.map { |category| Location.new category }
    end
  end

  def initialize(attrs = {})
    attrs.each do |key, value|
      self.send("#{key.to_s}=", value) if LOC_ATTRS.member? key.to_sym
    end
  end

end
