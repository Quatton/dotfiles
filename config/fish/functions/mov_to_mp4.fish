function mov_to_mp4
  set src "$argv"
  set out_dir "$HOME/Documents/Drive/Videos/$argv[2]/"

  if test -z $src
    echo "Usage: mov_to_mp4 <src>"
    return 1
  end

  if test -f $src
    ffmpeg -i $src -c:v libx264 -crf 23 -preset medium -c:a aac -b:a 128k -ac 2 $out_dir$src:r.mp4
  else
    echo "File not found: $src"
    return 1
  end
end