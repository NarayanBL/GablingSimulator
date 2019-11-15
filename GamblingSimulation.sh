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
totalBetResult=0
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
	echo $dailyBetResult
}

function dailyBetting() {
	while [[ $dailyBetResult -lt $maxWin && 
            $dailyBetResult -gt $maxLoss ]]
	do
		dailyBetResult="$( makeBetAndUpdate )"
	done
	echo $dailyBetResult
}

function monthlyBetting() {
	
	for (( day=1; day <= $NUM_OF_DAYS; day++ ))
	do
		dailyBetResult="$( dailyBetting )"
		totalBetResult=$(( $totalBetResult + $dailyBetResult ))	
		dailyResultDict[$day]=$totalBetResult
		dailyBetResult=0
	done
}

monthlyBetting
numOfEntries=${#dailyResultDict[@]}
allDays=${!dailyResultDict[@]}
allValues=${dailyResultDict[@]}
finalResult=$totalBetResult
