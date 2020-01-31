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
player1Position=$PLAYER_START_POSITION
player2Position=$PLAYER_START_POSITION
playingTurn=$PLAYER1
numberOfTimeDiceTossedByPlayer1=0
numberOfTimeDiceTossedByPlayer2=0
flagForPlayer1=0
flagForPlayer2=0

#FUNCTIONS
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

function diceTossedByPlayer1(){
	((numberOfTimeDiceTossedByPlayer1++))
}
function diceTossedByPlayer2(){
	((numberOfTimeDiceTossedByPlayer2++))
}

function positionAfterEveryDieForPlayer(){
	echo " " $2" is:"$1
}
function getWinner(){
	if [ $1 -gt $2 ]
	then
		echo "Player-1 is Winner..!!"
	else
		echo "Player-2 is Winner..!!"
	fi
}

#MAIN
while [ $flagForPlayer1 -eq 0 -a $flagForPlayer2 -eq 0 ]
do
	if [ $playingTurn -eq  $PLAYER1 ]
	then
		player1Position=$(checkNoPlaySnakeOrLadder $(rollDie) $player1Position )
		player1Position=$(checkPositionBelowZero $player1Position )
		positionAfterEveryDieForPlayer $player1Position $"player1Position"
		flagForPlayer1=$(winnerDecider $player1Position )
		diceTossedByPlayer1
		playingTurn=$PLAYER2
	else
		player2Position=$(checkNoPlaySnakeOrLadder $(rollDie) $player2Position )
		player2Position=$(checkPositionBelowZero $player2Position )
		positionAfterEveryDieForPlayer $player2Position $"player2Position"
		flagForPlayer2=$(winnerDecider $player2Position )
		diceTossedByPlayer2
		playingTurn=$PLAYER1
	fi
done
getWinner $flagForPlayer1 $flagForPlayer2
