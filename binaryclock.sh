# !/bin/bash

function decToBin { echo "ibase=10; obase=2; $1" | bc; };

draw() {
  for i in {31..6..-5}
    do
      decToBin {$(date '+%s')} | tail -c $i | head -c 5
      if [ $i = 6 ]
        then
        break
      fi
      printf "\n"
    done
}

printf '\e[?25l'
clear 
while true ; do
  printf '\033[;H' 
  offset_v=$(( $(( $(tput lines)  / 2  ))  - 3  ))
  v=$(( $offset_v > 0 ? $offset_v : 0 )); 
  for i in `seq 1 $v`;
    do
        printf "\n"
    done

  offset_h=$(( $(( $(tput cols)  / 2  ))  - 7  ))
  h=$(( $offset_h > 0 ? $offset_h : 0 )); 
  draw | sed "s/1/ $(tput setaf 6)● /g" | sed "s/0/ $(tput setaf 6)○ /g" | sed "s/^/$(head -c $h < /dev/zero | tr '\0' '\ ';)/"
  sleep 1
done