#!/bin/bash


CPUMAX=$(lscpu | grep "On-line CPU(s) list:" | awk '{print $4}'| awk -F'-' '{print $2}')
CPUMIN=$(lscpu | grep "On-line CPU(s) list:" | awk '{print $4}'| awk -F'-' '{print $1}')


aff_per_core(){
  CPUID=$1
  if [ "$CPUID" -gt "$CPUMAX" ] || [ "$CPUID" -lt "$CPUMIN" ]; then
    echo "CPU ID must be between $CPUMIN-$CPUMAX"
    exit 1
  else
    while read line; do
      PID=$(echo $line | awk '{print $1}')
      CMD=$(echo $line | awk '{print $6}')
      AFF=$(taskset -c -p $PID | awk '{print $6}')

      varA=(${AFF//,/ })
      for f in ${varA[@]}; do
        if [[ "$f" =~ "-" ]]; then 
          DOWNC=$(echo $f | awk -F'-' '{print $1}')
          UPTOC=$(echo $f | awk -F'-' '{print $2}')
          if [ "$CPUID" -ge "$DOWNC" ] && [ "$CPUID" -le "$UPTOC" ]; then
            NUMA=$(_numa "${AFF}")
            _print "${NUMA}" "${AFF}" "${PID}" "${CMD}"
          fi
        else
          if [ "$CPUID" -eq "$f" ]; then
            NUMA=$(_numa "${AFF}")
            _print "${NUMA}" "${AFF}" "${PID}" "${CMD}"
          fi
        fi
      done   
    done <<< $(ps -ec --no-header --sort cmd)
  fi
}

process_aff(){
  while read line; do
    PID=$(echo $line | awk '{print $1}')
    CMD=$(echo $line | awk '{print $6}')
    AFF=$(taskset -c -p $PID | awk '{print $6}')
    NUMA=$(_numa "${AFF}")
    _print "${NUMA}" "${AFF}" "${PID}" "${CMD}"
  done <<< $(ps -ec --no-header --sort cmd | grep $1)
}

all_aff_per_core(){
  while read line; do
    PID=$(echo $line | awk '{print $1}')
    CMD=$(echo $line | awk '{print $6}')
    AFF=$(taskset -c -p $PID | awk '{print $6}')
    NUMA=$(_numa "${AFF}")
    _print "${NUMA}" "${AFF}" "${PID}" "${CMD}"
  done <<< $(ps -ec --no-header --sort cmd)
}

_print(){
  echo "numa: ${NUMA};;cpu id: $AFF;; pid: $PID;; cmd: $CMD" | awk -F';;' '{printf "%-20s %-25s %-25s %-4s\n",$1,$2,$3,$4}'
}


_numa(){
  
  NUMANO=$(lscpu | egrep "NUMA\ node.* CPU.+" | wc -l)

  i=0
  while [[ $i -lt 2 ]]; do

    var=$(numactl -H | egrep "node "$i" cpus" | awk -F':' '{print $2}')
    affvar=$(echo ${1} | sed 's/[-,]/|/g')

    if [[ $(echo ${var} | egrep -w "${affvar}") ]]; then
      numaaff+="$i-"
    fi

    (( i += 1 ))
  done
  echo ${numaaff} | sed 's/-$//g'
}

usage(){
  
  cat <<EOF
  Usage: $(basename $0) [-i (cpu core id)] [-p process] [-a] [-h]

    -h      help
    -c      cpu core id
    -p      process name
    -a      list procesess for all cpu cores

EOF
  exit 0
}



while getopts ":c:p:ah" arg; do
  case "${arg}" in
    c) 
      CPUID=${OPTARG}
      aff_per_core "${CPUID}"
      ;;
    p) 
      PROCESS=${OPTARG}
      process_aff "${PROCESS}"
      ;;
    a)
      all_aff_per_core
      ;;
    h|*)
      usage
      ;;
  esac
done
