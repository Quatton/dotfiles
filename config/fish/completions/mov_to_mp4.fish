complete -c mov_to_mp4 -f
# complete with ~/Documents/Drive/Videos/Raw\ Recordings/*.mov\
complete -c mov_to_mp4 -a '(ls ~/Documents/Drive/Videos/Raw\ Recording/*.mov | sed "s/ /\\\\ /g")'
