function compress_video
  set src "$argv[1]"
  set out_dir "$argv[2]"
  set speed "$argv[3]"

  if test -z $src
    echo "Usage: compress_video <src> <output_dir> [speed]"
    return 1
  end

  # If output directory is not provided, use the source file's directory
  if test -z "$out_dir"
    set out_dir (dirname "$src")
  end

  # if directory doesn't exist, prompt to create
  if not test -d $out_dir
    echo "Directory $out_dir does not exist. Create it? [y/n]"
    read -l create_dir
    if test $create_dir = "y"
      mkdir -p $out_dir
    else
      return 1
    end
  end

  # slash-aware path joining
  set out_dir (string replace -r '/$' '' $out_dir)
  set out_basename (string replace -r '^/' '' "$(basename $src)-compressed.mp4")
  set file (string join '/' $out_dir $out_basename)

  if test -z $file
    echo "File name could not be determined."
    return 1
  end

  if test -f $src
    # Default speed is 1.0 (normal speed)
    if test -z "$speed"
      set speed 1.0
    end
    
    # Generate atempo filter string for audio speed adjustment
    set audio_tempo (get_atempo_filter $speed)
    
    # Changed CRF from 23 to 18 for higher quality output
    ffmpeg -i $src -vf "scale=1280:-2,setpts=PTS/$speed" -af "$audio_tempo" -c:v libx264 -crf 18 -preset medium -c:a aac -b:a 128k -ac 2 $file -y

    if test $status -eq 0
      echo "Video compressed successfully: $file"
    else
      echo "Error compressing video."
      return 1
    end
  else
    echo "File not found: $src"
    return 1
  end
end

# Helper function to generate appropriate atempo filter chain
function get_atempo_filter
  set speed $argv[1]
  
  # If speed is 1.0, no audio adjustment needed
  if test "$speed" = "1.0"
    echo "atempo=1.0"
    return
  end
  
  # FFmpeg's atempo filter only supports 0.5 to 2.0 range
  # For higher speeds, we need to chain multiple atempo filters
  set atempo_chain ""
  set remaining_speed $speed
  
  while test (math "$remaining_speed > 2.0") -eq 1
    set atempo_chain "$atempo_chain"atempo=2.0,
    set remaining_speed (math "$remaining_speed / 2.0")
  end
  
  if test (math "$remaining_speed < 0.5") -eq 1
    # Handle extremely slow speeds
    while test (math "$remaining_speed < 0.5") -eq 1
      set atempo_chain "$atempo_chain"atempo=0.5,
      set remaining_speed (math "$remaining_speed / 0.5")
    end
  end
  
  # Add the final atempo value
  set atempo_chain "$atempo_chain"atempo=$remaining_speed
  
  echo $atempo_chain
end
