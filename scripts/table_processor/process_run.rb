#!/usr/bin/env ruby

cur = -1

n = -1

times = {}
File.open('raw_data').each do |line|
  next if line =~ /^#.*/

  cur = $1.to_i if line =~ /^%(\d*)/

  if line =~ /^Running with (\d*)/
    n = $1.to_i
    times[n] ||= []
    times[n][cur] ||= []
  end


  times[n][cur][0] = $1 if line =~ /Online time: (\d*(\.\d*)?(e\+\d*)?) milli seconds/
  times[n][cur][1] = $1 if line =~ /Pattern Preprocessing time: (\d*(\.\d*)?(e\+\d*)?) milli seconds/

end

def convert_ms ms
  ms = ms.to_f

  x = (ms / 1000).to_i
  seconds = x % 60
  x /= 60
  minutes = x % 60
  x /= 60
  hours = x % 24
  x /= 24
  days = x
  ms = ms % 1000

  ret ||= ""
  ret += "#{days} days " if days > 0
  ret += "#{hours} hours " if hours > 0
  ret += "#{minutes} min. " if hours == 0 and minutes > 0
  ret += "#{seconds}s " if hours == 0 and seconds > 0
  ret += "#{ms.round(3)}ms" if minutes == 0

  ret
end

times.each {|k,v|
  times[k][0].pop(1)
  times[k][2].pop(1)

  times[k] = times[k].flatten
}

times.each {|k,v|
  times[k].collect!{ |x| convert_ms(x) }
}

times.each {|k,v|
  puts "#{k}: #{v.inspect}"
}

times.each {|k,v|
  puts "$10^#{Math.log(k.to_i, 10).to_i}$ & #{v.join(' & ')}\\\\ \\hline"
}
