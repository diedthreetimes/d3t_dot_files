#!/usr/bin/env ruby

require 'openssl'

m = OpenSSL::BN.generate_prime(160)

num_trials = 100000
time_exp = true
time_hash = true


if time_exp
  start = Time.now
  num_trials.times do
    a = rand(m).to_bn
    b = rand(m)

    a.mod_exp(b,m)
  end
  finish = Time.now

  puts "Modular Exponentiation Takes: #{(finish-start)/num_trials}"
end

if time_hash
  digest = OpenSSL::Digest::SHA1.new
  length_of_msg = 160/8

  r = Random.new
  start = Time.now
  num_trials.times do
    digest.reset
    a = r.bytes(length_of_msg)
    #a = rand(m).to_s
    #b = rand(m)

    digest.digest(a)
  end
  finish = Time.now

  puts "SHA1 Takes: #{(finish-start)/num_trials}"
end
