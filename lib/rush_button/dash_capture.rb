require 'packetfu'
require 'net/http'

module RushButton
  class DashCapture
    include PacketFu
    
    REFER_URL = "https://api.macvendors.com/"
    VENDOR_NAME = "Amazon Technologies Inc."
    
    def initialize iface
      @capture = Capture.new(iface: iface, filter: Protocol::ARP, promisc: true)
    end
    
    def capture
      loop do
        packet = @capture.next
        unless packet
          sleep 1
          next
        end
        if ARPPacket.can_parse? packet
          src_mac = ARPPacket.parse(packet).eth_src_readable
          vendor_mac = (src_mac.split(":"))[0..2].join(":")
          puts "captured MAC: #{src_mac}" if $DEBUG
          puts "refer to #{REFER_URL+vendor_mac}..." if $DEBUG 
          vendor_name = Net::HTTP.get URI.parse(REFER_URL+vendor_mac)
          puts "vendor name: #{vendor_name}" if $DEBUG
          if vendor_name == VENDOR_NAME
            puts "this is Amazon!" if $DEBUG
            return src_mac
          end
        end
      end
    end
  end
end
