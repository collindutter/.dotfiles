function reva-rabbitmq --wraps='ssh -p 22255 collin@jumpbox.corp.reva.tech -L 16000:172.31.10.140:15672 -N' --description 'alias reva-rabbitmq=ssh -p 22255 collin@jumpbox.corp.reva.tech -L 16000:172.31.10.140:15672 -N'
  ssh -p 22255 collin@jumpbox.corp.reva.tech -L 16000:172.31.10.140:15672 -N $argv
        
end
