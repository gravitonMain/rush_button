require "rush_button"

iface = ARGV[0]
mac_addr = ARGV[1]
srv = RushButton::Server.new(iface)
srv.add(mac_addr) do
  puts "|#{Time.now}| Pressed!"
end
srv.start
