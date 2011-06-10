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

require 'win32/console/ansi'
require 'fileutils'

begin
  # load wirble
  require 'wirble'

  # start wirble (with color)
  Wirble.init
  Wirble.colorize
rescue LoadError => err
  warn "Couldn't load Wirble: #{err}"
end


def ls
  Dir["**"]
end

def cd dir
  FileUtils.cd dir
  FileUtils.pwd
end

def pwd
  FileUtils.pwd
end
