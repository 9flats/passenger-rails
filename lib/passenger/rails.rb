module Passenger
  module Rails
    require 'passenger/rails/version'
  end
end

module Rack
  module Handler
    class Passenger
      class << self
        def run(app, options = {})
          port = "-p #{options[:Port]}"
          address = "-a #{options[:Host]}"
          rack_up_file_path = "-R #{options[:config]}"
          env = "-e #{environment}"
          pool = "--max-pool-size 2"

          system "passenger start #{[port, address, rack_up_file_path, env, pool].join(' ')}"
        end

        def environment
          ENV['RACK_ENV'] || ENV['RAILS_ENV']
        end
      end
    end

    register 'passenger', 'Rack::Handler::Passenger'

    def self.default(options = {})
      Rack::Handler::Passenger
    end
  end
end
