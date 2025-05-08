function mcdonalds
  while true
    sudo networksetup -setairportpower en0 off
    sudo networksetup -setairportpower en0 on
    sudo ifconfig en0 ether $(openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/.$//')
    if test $status -eq 0
      break
    end
  end
end