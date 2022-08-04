#!/usr/bin/env ruby

# Generate a list of v4 UUIDs in canonical and base64url representation.

require 'securerandom'

puts '-' * 60
puts 'Canonical UUID' + ' ' * 24 + 'base64url'
puts '=' * 60

(ARGV[0] || 10).to_i.times do
  uuid = SecureRandom.uuid

  uuid_base64 = [[uuid.delete('-')].pack('H*')].pack('m0')
  uuid_base64 = uuid_base64.delete('=').tr('+/', '-_')

  puts "#{uuid}  #{uuid_base64}"
end

puts '-' * 60
