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

# Starting of the Main Program

monthlyBetting
findBestAndWorstDays

numOfEntries=${#dailyResultDict[@]}
allDays=${!dailyResultDict[@]}
allValues=${dailyResultDict[@]}
finalResult=$totalBetResult
echo "Best Day " $bestDay " = " $bestDayResult
echo "Worst Day " $worstDay " = " $worstDayResult
