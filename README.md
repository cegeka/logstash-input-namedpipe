# Logstash input named pipe plugin

This is a plugin for [Logstash](https://github.com/elastic/logstash).

This plugin is slightly based on the Logstash cookbook named pipe plugin. It did not work out of the box for me, so I fixed the code. Reference: https://www.logstashbook.com/code/8/namedpipe.rb

## Building

```
gem build logstash-input-namedpipe.gemspec
```

## Installation

```
logstash$ ./logstash-plugin install ~/logstash-input-namedpipe-0.1.0.gem
```

## Usage

```
input {
  namedpipe {
    pipe => '/var/run/some_pipe'
  }
}
```
