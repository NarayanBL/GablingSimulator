#!/bin/bash -x

echo "Welcome to Gambling Simulator Program"

#CONSTANTS
WON=1
LOSS=0
STAKE=100
BET_AMOUNT=1
DAILY_RESIGN_PERC=50
NUM_OF_DAYS=20

#Variable
dailyBetResult=0
maxWin=$(($STAKE*DAILY_RESIGN_PERC/100))
maxLoss=$((-$STAKE*DAILY_RESIGN_PERC/100))

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
   dailyBetResult=$(($dailyBetResult+$betAmount))
}

function dailyBetting() {
	while [[ $dailyBetResult -lt $maxWin && 
            $dailyBetResult -gt $maxLoss ]]
	do
		makeBetAndUpdate
	done
}

function monthlyBetting() {
	
	for (( day=1; day <= $NUM_OF_DAYS; day++ ))
	do
   	dailyBetting
		totalBetResult=$(( $totalBetResult + $dailyBetResult ))	
		dailyBetResult=0
	done
	echo $totalBetResult
}

monthlyBetting
