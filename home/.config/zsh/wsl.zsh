# Genie installed? 
if [[ ! -z $(command -v genie) ]] then

  # Are we in the bottle?
  if [[ ! -v INSIDE_GENIE ]] then
    read -t 5 yn\?"Preparing to enter genie bottle in 5s. Enter [Yn]? "
  
    if [[ $yn != "n" ]]; then
      # Save path to file (includes vscode and other paths that are not automatically added when entering genie bottle
      echo $PATH > /tmp/.zshrc.path.tmp
  
      exec /usr/bin/genie -s
    fi
  else
    echo "Entered bottle"
  
    [[ -f /tmp/zshrc.path.tmp ]] && export PATH=$(cat /tmp/.zshrc.path.tmp) && rm /tmp/.zshrc.path.tmp
  fi
fi


