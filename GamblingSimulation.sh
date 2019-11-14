#!/bin/bash -x

echo "Welcome to Gambling Simulator Program"
WON=1
LOSS=0
STAKE=100
BET_AMOUNT=1

function makeBet() {
	local betStatus=$((RANDOM%2))
	if [ $WON -eq $betStatus ]
	then 
   	echo $BET_AMOUNT
	else 
		echo -$BET_AMOUNT
	fi
}

makeBet
