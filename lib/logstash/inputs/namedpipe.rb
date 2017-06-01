# encoding: utf-8
require "logstash/inputs/base"
require "logstash/namespace"
require "stud/interval"
require "socket" # for Socket.gethostname

# Generate a repeating message.
#
# This plugin is intented only as an example.

class LogStash::Inputs::Namedpipe < LogStash::Inputs::Base
  config_name "namedpipe"

  # If undefined, Logstash will complain, even if codec is unused.
  default :codec, "line"

  # The pipe to read from
  config :pipe, :validate => :string, :required => true

  public
  def register
      @logger.info("Registering namedpipe input", :pipe => @pipe)
  end # def register


  def run(queue)
      @pipe = open(pipe, "r+")
      @pipe.each do |line|
        line = line.chomp
        host = Socket.gethostname
        @logger.debug("Received line", :host => host, :pipe => pipe, :message => line)
        event = LogStash::Event.new("host" => host, "message" => line)
        decorate(event)
        queue << event
      end
  end # def run


  def stop
        @pipe.close
      finished
  end
end # class LogStash::Inputs::Namedpipe
