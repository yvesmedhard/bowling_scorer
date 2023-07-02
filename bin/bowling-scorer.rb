#!/usr/bin/env ruby
begin
  require_relative '../lib/bowling_scorer'

  BowlingScorer.new(ARGV).render
rescue LoadError => e
  puts e.message
  puts 'You must first run `bundle install` to install the required gems.'
  exit 1
end
