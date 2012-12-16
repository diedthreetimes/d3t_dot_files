#!/usr/bin/env ruby

# A small script to go through a directory of images and print the number

in_dir = ARGV[0]
puts Dir.glob("#{in_dir}/*.JPG").collect{|x|
  x =~ /\/DSC_([0-9]*).JPG/

  $1
}
