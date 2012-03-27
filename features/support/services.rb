require "service_manager"

ServiceManager.start

at_exit { ServiceManager.stop }

