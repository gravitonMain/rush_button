require 'packetfu'

module RushButton
  class Server
    include PacketFu
    def initialize iface
      @iface = iface
      @buttons = []
    end
    
    def add mac_addr, &block
      @buttons << DashButton.new(mac_addr).on_press(&block)
    end
    
    def start
      puts "Dash Button capturing..." if $DEBUG
      cap = Capture.new(iface:@iface, filter:Protocol::ARP, promisc:true)
      cap.stream.each do |pkt|
        if ARPPacket.can_parse?(pkt)
          src_mac = ARPPacket.parse(pkt).eth_src_readable
          @buttons.find {|e| e.mac == src_mac}&.press
        end
      end
    end
  end
end
