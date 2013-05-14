#!/usr/bin/env ruby

require 'net/ssh'
require 'net/scp'

PRI_KEY = %w[ root.pem ]
KEYS= %w[ ex.pub ]
KEYS_p = %w[ ex.pem ]


key_dir = "."

HOSTS = %w[]
user = 'ec2-user'

for host in HOSTS
  succeed = false
  begin
    Net::SSH.start(host, user, :keys => PRI_KEY) do |ssh|

      output = ssh.exec!("whoami")

      if(output =~ /#{user}/)
        succeed = true
      end
    end

    if !succeed then
      puts "#{host} connection incorrect!"
      next
    end
  rescue
    puts "#{host} connection failed"
    next
  end

  #TODO: loop over keys
  key = KEYS[0]

  Net::SSH.start(host,user,:keys => PRI_KEY) do |ssh|
    output = ssh.exec!("pwd")
  end

  # SSH worked now we scp over the new key
  Net::SCP.upload!(host, user, "#{key_dir}/#{key}", "/home/#{user}/.ssh/#{key}", :ssh => {:keys => PRI_KEY})

  # Check to see that the upload succeeded
  Net::SSH.start(host, user, :keys => PRI_KEY) do |ssh|

    output = ssh.exec!("ls /home/#{user}/.ssh/#{key}")

    if(!(output =~ /#{user}\/.ssh\/#{key}/))
      puts "#{host} file not found"
      next
    end

    ssh.exec!("cp /home/#{user}/.ssh/authorized_keys /home/#{user}/.ssh/authorized_keys.bak1")
    ssh.exec!("cat /home/#{user}/.ssh/#{key} >> /home/#{user}/.ssh/authorized_keys")
  end

  Net::SSH.start(host, user, :keys => KEYS_p) do |ssh|

    output = ssh.exec!("pwd")
    if(!(output =~ /#{user}/))
      puts "#{host} cannot connect with new key"
      puts output
      next
    end

  end

  Net::SSH.start(host, user, :keys => PRI_KEY) do |ssh|

    output = ssh.exec!("pwd")
    if(!(output =~ /#{user}/))
      puts "#{host} cannot connect with old key"
      puts output
      next
    end

  end

end
