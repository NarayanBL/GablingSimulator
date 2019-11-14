#!/bin/bash -x

echo "Welcome to Gambling Simulator Program"

#CONSTANTS
WON=1
LOSS=0
STAKE=100
BET_AMOUNT=1
DAILY_RESIGN_PERC=50

#Variable
dailyBetAmount=$STAKE
maxTotalDailyAmount=$(($STAKE+$STAKE*DAILY_RESIGN_PERC/100))
minTotalDailyAmount=$(($STAKE-$STAKE*DAILY_RESIGN_PERC/100))

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

function dailyBetting() {
	while [[ $dailyBetAmount -lt $maxTotalDailyAmount && 
            $dailyBetAmount -gt $minTotalDailyAmount ]]
	do
		makeBetAndUpdate
	done
}

dailyBetting
echo $dailyBetAmount
