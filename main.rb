#!/usr/bin/env ruby

require 'open-uri'
require 'nokogiri'
require 'sequel'
require 'logging'
require 'json'
require 'thread/pool'


require_relative 'app/lib/my_extension'
require_relative 'app/task_page'


pool = []
tpool = Thread.pool(10)

(1..2211).each do |id|
  pool << TaskPage.new(id)
end

start = Time.now

pool.each {|t| tpool.process {t.start_process!}}
tpool.shutdown
#
# pool.each_slice(10) do |group|
#   group.map do |t|
#     Thread.new {t.start_process!}
#   end.each(&:join)
# end

start2 = Time.now

puts "Cost #{start2 - start} seconds to load page."


open('db.json', "w") do |f|
  pool.reject! {|t| t.state != :processed}
  JSON.dump(pool, f)
end

puts "Cost #{Time.now - start2} seconds to write data."