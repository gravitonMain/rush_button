module RushButton
  class DashButton
    attr_reader :mac
    def initialize mac_addr
      @mac = mac_addr
    end
    
    def on_press &process
      @process = process
      return self
    end
    
    def press
      return @process.call
    end
  end
end
