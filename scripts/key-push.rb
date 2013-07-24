#!/usr/bin/env ruby

require 'net/ssh'
require 'net/scp'

PRI_KEY = %w[ ]

KEYS_TO_ADD = %w[ ]

key_dir = "."

HOSTS = %w[ ]
#user = 'ec2-user'
#home_dir = '/home/ec2-user'
user = 'root'
home_dir = '/root'

for key in KEYS_TO_ADD
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

    Net::SSH.start(host,user,:keys => PRI_KEY) do |ssh|
      output = ssh.exec!("pwd")
    end

    # SSH worked now we scp over the new key
    Net::SCP.upload!(host, user, "#{key_dir}/#{key}.pub", "#{home_dir}/.ssh/#{key}.pub", :ssh => {:keys => PRI_KEY})

    # Check to see that the upload succeeded
    Net::SSH.start(host, user, :keys => PRI_KEY) do |ssh|

      output = ssh.exec!("ls #{home_dir}/.ssh/#{key}.pub")

      if(!(output =~ /#{user}\/.ssh\/#{key}.pub/))
        puts "#{host} file not found"
        next
      end

      ssh.exec!("cp #{home_dir}/.ssh/authorized_keys #{home_dir}/.ssh/authorized_keys.bak1")
      ssh.exec!("cat #{home_dir}/.ssh/#{key}.pub >> #{home_dir}/.ssh/authorized_keys")
    end

    Net::SSH.start(host, user, :keys => [key+".pem"]) do |ssh|

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
end
