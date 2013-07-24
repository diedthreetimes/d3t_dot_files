#require 'rubygems'
#require 'irbtools'

#require 'fileutils'
#include FileUtils

#IRB.conf[:PROMPT][:CUSTOM] = {
#    :PROMPT_I => "%N(%m):%03n:%i %~> ".tap {|s| def s.dup; gsub('%~', Dir.pwd); end },
#    :PROMPT_S => "%N(%m):%03n:%i %~%1 ".tap {|s| def s.dup; gsub('%~', Dir.pwd); end },
#    :PROMPT_C => "%N(%m):%03n:%i %~* ".tap {|s| def s.dup; gsub('%~', Dir.pwd); end },
#    :RETURN => "%s\n"
#}
#IRB.conf[:PROMPT_MODE] = :CUSTOM

#require 'win32/console/ansi'
# require 'fileutils'

# begin
#   # load wirble
#   require 'rubygems'
#   require 'wirble'

#   # start wirble (with color)
#   Wirble.init
#   Wirble.colorize
# rescue LoadError => err
#   warn "Couldn't load Wirble: #{err}"
# end


# def ls( dir = '' )
#   Dir[File.join( dir, "**")]
# end

# def cd dir
#   FileUtils.cd dir
#   FileUtils.pwd
# end

# def pwd
#   FileUtils.pwd
# end

# https://github.com/carlhuda/bundler/issues/183#issuecomment-1149953
if defined?(::Bundler)
  global_gemset = ENV['GEM_PATH'].split(':').grep(/ruby.*@global/).first
  if global_gemset
    all_global_gem_paths = Dir.glob("#{global_gemset}/gems/*")
    all_global_gem_paths.each do |p|
      gem_path = "#{p}/lib"
      $LOAD_PATH << gem_path
    end
  end
end
# Use Pry everywhere
require "rubygems"
require 'pry'
Pry.start
Pry.config.pager = false
exit

