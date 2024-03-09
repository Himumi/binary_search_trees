class Node
    attr_accessor :data, :left, :right
  
    def initialize(data)
      @data = data
      @left = nil
      @right = nil
    end
  
    def to_s
      "#{@data}"
    end
  end