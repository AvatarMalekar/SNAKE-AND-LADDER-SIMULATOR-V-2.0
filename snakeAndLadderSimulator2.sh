#!/bin/bash -x
echo "-------------------------------------------WELLCOME TO SNAKE AND LADDER SIMULATOR---------------------------------------------"
NO_PLAY=0;
SNAKE=1;
LADDER=2;

playerStartPosition=0

function rollDie(){
	local die=$((RANDOM%6+1))
	echo $die
}

function checkNoPlaySnakeOrLadder(){
	local playerPosition=$2
	case $((RANDOM%3)) in
		$NO_PLAY)
			playerPosition=$playerPosition
			;;
		$SNAKE)
			playerPosition=$(($playerPosition-$1))
			;;
		$LADDER)
			playerPosition=$(($playerPosition+$1))
			;;
	esac
	echo $playerPosition
}

playerStartPosition=$(checkNoPlaySnakeOrLadder $(rollDie) $playerStartPosition )
