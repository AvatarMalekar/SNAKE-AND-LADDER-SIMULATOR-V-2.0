#!/bin/bash
echo "-------------------------------------------WELLCOME TO SNAKE AND LADDER SIMULATOR---------------------------------------------"

#CONSTANT
NO_PLAY=0;
SNAKE=1;
LADDER=2;
WINNING_POSITION=100;
PLAYER_START_POSITION=0;
PLAYER1=0
PLAYER2=1

#VARIABLES
declare -A playerDictionary
playerDictionary[Player1]=$PLAYER_START_POSITION
playerDictionary[Player2]=$PLAYER_START_POSITION
numberOfTimeDiceTossedByPlayer1=0
numberOfTimeDiceTossedByPlayer2=0
i=1
x=3

#FUNCTIONS
function rollDie(){
	local die=$((RANDOM%6+1))
	echo $die
}
function diceTossed(){
	if [ $1 -eq 1 ]
	then
		((numberOfTimeDiceTossedByPlayer1++))
	else
		((numberOfTimeDiceTossedByPlayer2++))
	fi
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
	playerTempPosition=$(checkPositionBelowZero $playerTempPosition )
	echo $playerTempPosition
}
function positionAfterEveryDieForPlayer(){
   echo "position of "$2 "is" $1
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
function getWinner(){
	if [ $1 -eq $WINNING_POSITION ]
	then
		echo " "$2 "is Winner..!!"
	fi
}

#MAIN
while [ ${playerDictionary[Player1]} -ne $WINNING_POSITION -a ${playerDictionary[Player2]} -ne $WINNING_POSITION ]
do
	playerDictionary[Player"$i"]=$(checkNoPlaySnakeOrLadder $(rollDie) ${playerDictionary[Player"$i"]} )
	positionAfterEveryDieForPlayer ${playerDictionary[Player"$i"]} $"PLayer-$i"
	diceTossed $i
	getWinner ${playerDictionary[Player"$i"]} $"PLayer-$i"
	i=$(($x-$i))
done
