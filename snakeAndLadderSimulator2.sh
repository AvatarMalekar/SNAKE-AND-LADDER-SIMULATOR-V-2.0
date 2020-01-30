#!/bin/bash
echo "-------------------------------------------WELLCOME TO SNAKE AND LADDER SIMULATOR---------------------------------------------"
NO_PLAY=0;
SNAKE=1;
LADDER=2;
WINNING_POSITION=100;
PLAYER_START_POSITION=0;

playerPosition=$PLAYER_START_POSITION
numberOfTimeDiceTossed=0
flag=0
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
	playerTempPosition=$(getExactWinningPosition $playerTempPosition $1 )
	echo $playerTempPosition
}

function checkPositionBelowZero(){
	local position=$1
	if [ $position -lt 0 ]
	then
		position=0
	fi
	echo $position
}
function getExactWinningPosition(){
	local position=$1
	if [ $position -gt $WINNING_POSITION ]
   then
      position=$(($position-$2))
   fi
	echo $position
}
function winnerDecider(){
	if [ $1 -eq 100 ]
	then
		local flagValue=1
	else
		flagValue=0
	fi
	echo $flagValue
}

function diceTossed(){
	((numberOfTimeDiceTossed++))
}

function positionAfterEveryDieForPlayer(){
	echo "Position is:"$1
}
while [ $flag -eq 0 ]
do
	playerPosition=$(checkNoPlaySnakeOrLadder $(rollDie) $playerPosition )
	playerPosition=$(checkPositionBelowZero $playerPosition )
	positionAfterEveryDieForPlayer $playerPosition
	flag=$(winnerDecider $playerPosition )
	diceTossed
done
echo "Final Position of Player:"$playerPosition
echo "Number of times dice tossed:"$numberOfTimeDiceTossed
