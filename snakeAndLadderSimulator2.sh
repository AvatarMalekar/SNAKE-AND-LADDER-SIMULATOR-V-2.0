#!/bin/bash -x
echo "-------------------------------------------WELLCOME TO SNAKE AND LADDER SIMULATOR---------------------------------------------"
NO_PLAY=0;
SNAKE=1;
LADDER=2;
WINNING_POSITION=100;
PLAYER_START_POSITION=0;

playerPosition=$PLAYER_START_POSITION

function rollDie(){
	local die=$((RANDOM%6+1))
	echo $die
}

function checkNoPlaySnakeOrLadder(){
	local playerTempPosition=$2
	case $((RANDOM%3)) in
		$NO_PLAY)
			playerTempPosition=$playerTempPosition
			;;
		$SNAKE)
			playerTempPosition=$(($playerTempPosition-$1))
			;;
		$LADDER)
			playerTempPosition=$(($playerTempPosition+$1))
			;;
	esac
	echo $playerTempPosition
}

function checkPositionBelowZero(){
	if [ $1 -lt 0 ]
	then
		echo $(($1*0))
	else
		echo $1
	fi
}

while [ $playerPosition -le $WINNING_POSITION ]
do
	playerPosition=$(checkNoPlaySnakeOrLadder $(rollDie) $playerPosition )
	playerPosition=$(checkPositionBelowZero $playerPosition )
done
