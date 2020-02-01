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
numberOfTimeDiceTossed=0

#THESE VARIABLES ARE USED FOR SWITCHING PLAYERS 
playerSwitch=$PLAYER2
playerSwitchingLimit=3

#FUNCTIONS
function rollDie(){
	echo $((RANDOM%6+1))
}

function diceTossed(){
	((numberOfTimeDiceTossed++))
}

function checkNoPlaySnakeOrLadder(){
	local playerCurrentPosition=$2
	local dieValue=$1
	case $((RANDOM%3)) in
		$NO_PLAY)
			playerCurrentPosition=$playerCurrentPosition
			;;
		$SNAKE)
			playerCurrentPosition=$(($playerCurrentPosition-$dieValue))
			;;
		$LADDER)
			playerCurrentPosition=$(($playerCurrentPosition+$dieValue))
			;;
		*)
			echo "Invalid Position"
			;;
	esac
	playerCurrentPosition=$(getExactWinningPosition $playerCurrentPosition $dieValue )
	playerCurrentPosition=$(checkPositionBelowZero $playerCurrentPosition )
	echo $playerCurrentPosition
}

function positionAfterEveryDieForPlayer(){
	local position=$1
	local player=$2
	echo "position of "$player "is" $position
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
	local dieValue=$2
	if [ $position -gt $WINNING_POSITION ]
	then
		position=$(($position-$dieValue))
	fi
	echo $position
}

function getWinner(){
	local position=$1
	local player=$2
	if [ $position -eq $WINNING_POSITION ]
	then
		echo ""$player "is Winner..!!"
	fi
}

#MAIN
while [ ${playerDictionary[Player1]} -ne $WINNING_POSITION -a ${playerDictionary[Player2]} -ne $WINNING_POSITION ]
do
	playerDictionary[Player"$playerSwitch"]=$(checkNoPlaySnakeOrLadder $(rollDie) ${playerDictionary[Player"$playerSwitch"]} )
	positionAfterEveryDieForPlayer ${playerDictionary[Player"$playerSwitch"]} $"PLayer-$playerSwitch"
	diceTossed
	getWinner ${playerDictionary[Player"$playerSwitch"]} $"PLayer-$playerSwitch" 
	playerSwitch=$(($playerSwitchingLimit-$playerSwitch)) #PLAYER SWITCHES HERE
done

echo "Total number of count of Dice tossed:-"$numberOfTimeDiceTossed
