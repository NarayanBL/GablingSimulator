#!/bin/bash -x

echo "Welcome to Gambling Simulator Program"

#CONSTANTS
WON=1
LOSS=0
STAKE=100
BET_AMOUNT=1

#Variable
dailyBetAmount=$STAKE

function makeBet() {
	local betStatus=$((RANDOM%2))
	if [ $WON -eq $betStatus ]
	then 
   	echo $BET_AMOUNT
	else 
		echo -$BET_AMOUNT
	fi
}

function makeBetAndUpdate() {
   local betAmount="$( makeBet )"
   dailyBetAmount=$(($dailyBetAmount+$betAmount))
}

makeBetAndUpdate

