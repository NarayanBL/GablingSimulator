#!/bin/bash -x

echo "Welcome to Gambling Simulator Program"

#CONSTANTS
WON=1
LOSS=0
STAKE=100
BET_AMOUNT=1
DAILY_RESIGN_PERC=2
NUM_OF_DAYS=2
NUM_OF_MONTHS_PLAYED=12

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

function doDailyBetting() {
	while [[ $dailyBetResult -lt $maxWin && 
            $dailyBetResult -gt $maxLoss ]]
	do
		dailyBetResult="$( makeBetAndUpdate )"
	done
	echo $dailyBetResult
}

function doMonthlyBetting() {
	
	for (( day=1; day <= $NUM_OF_DAYS; day++ ))
	do
		dailyBetResult="$( doDailyBetting )"
		totalBetResult=$(( $totalBetResult + $dailyBetResult ))	
		dailyResultDict[$day]=$totalBetResult
		dailyBetResult=0
	done
}

function findBestAndWorstDays() {
	bestDay=1
	worstDay=1
	bestDayResult=${dailyResultDict[1]}
	worstDayResult=${dailyResultDict[1]}

	for day in "${!dailyResultDict[@]}"; do
   	result=${dailyResultDict[$day]}
   	if [ $bestDayResult -lt $result ]
   	then
      	bestDayResult=$result
      	bestDay=$day
   	fi
   	if [ $worstDayResult -gt $result ]
   	then
      	worstDayResult=$result
      	worstDay=$day
   	fi
	done
}

continuePlaying=1
resultAtQuiting=0
numOfMonthsPlayed=0
function playGamblingSimulationGame() {

	doMonthlyBetting
	findBestAndWorstDays
	local numOfEntries=${#dailyResultDict[@]}
	local allDays=${!dailyResultDict[@]}
	local allValues=${dailyResultDict[@]}
	local finalResult=$totalBetResult
	echo "Best Day " $bestDay " = " $bestDayResult
	echo "Worst Day " $worstDay " = " $worstDayResult

	numOfMonthsPlayed=$(($numOfMonthsPlayed+1))
	resultAtQuiting=$(( $resultAtQuiting + $finalResult ))
	if [[ $finalResult -ge 0 && $numOfMonthsPlayed -lt $NUM_OF_MONTHS_PLAYED ]]
	then
		playGamblingSimulationGame
	fi
}

# Starting of the Main Program

playGamblingSimulationGame
numOfMonthsPlayed=$numOfMonthsPlayed
resultAtQuiting=$resultAtQuiting
