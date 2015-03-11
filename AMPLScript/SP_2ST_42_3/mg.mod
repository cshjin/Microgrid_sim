model;

set Directions;
set Scenarios;
param SIZE;
set Time:={1..SIZE};

#param Pi:= 4 * atan(1);
param P{s in Scenarios};
param InitBattery;
param Demand;
param Resources;
param Demand_stage;
param Resources_stage{s in Scenarios};
param BatteryCapacity;
param TransitionPrice;
param ReservePrice;
param SellingPrice;
param BuyingPrice;
param SellingPrice_stage;
param BuyingPrice_stage;
param WindSpeed{t in Time};
param CoolingDegreeHours{t in Time};
param HeatDegreeHours{t in Time};
param CloudOvercastPercentage {t in Time};
param StateSequence {t in Time};
param SolarRadi {t in Time};
param Buying {t in Time};
param Selling {t in Time};
param DemandSeq {t in Time};
param ResourcesSeq {t in Time};
param Prob{1..42, 1..42};

var amount{d in Directions} >=0;
var amount_stage{d in Directions, s in Scenarios} >=0, suffix stage 2;

minimize cost:
	TransitionPrice * (amount['BC']+amount['BG']
		+amount['GB']+amount['RB']) +
	ReservePrice * (InitBattery-amount['BC'] - amount['BG']
		+amount['GB']+amount['RB']) +
	BuyingPrice * (amount['GB'] + amount['GC']) -
	SellingPrice * (amount['BG'] + amount['RG']) + 
	
	sum {s in Scenarios} P[s] * (
		TransitionPrice * (
			amount_stage['BC',s]
			+amount_stage['BG',s]
			+amount_stage['GB',s]
			+amount_stage['RB',s]) +
		ReservePrice * (
			InitBattery
			-amount['BC'] 
			-amount['BG']
			+amount['GB']
			+amount['RB'] 
			-amount_stage['BC',s]
			-amount_stage['BG',s]
			+amount_stage['GB',s]
			+amount_stage['RB',s]) +
		BuyingPrice_stage * (
			amount_stage['GB',s] 
			+ amount_stage['GC',s]) -
		SellingPrice_stage * (
			amount_stage['BG',s] 
			+ amount_stage['RG',s]));

s.t. meetDemand:
	amount['BC'] + amount['GC'] + amount['RC'] 
		>= Demand;
s.t. meetDemand_stage{s in Scenarios}:
	amount_stage['BC',s]+amount_stage['GC',s]+ amount_stage['RC',s]
		>=Demand_stage;

s.t. batteryLimit:
	0 <= InitBattery-amount['BC'] - amount['BG']
		+amount['GB']+amount['RB'] <= BatteryCapacity;
s.t. batteryLimit_stage{s in Scenarios}:
	0 <= InitBattery-amount['BC'] - amount['BG']
		+amount['GB']+amount['RB'] 
		-amount_stage['BC',s] - amount_stage['BG',s]
		+amount_stage['GB',s] + amount_stage['RB',s]
		<= BatteryCapacity;

s.t. resourcesLimit:
	amount['RB'] + amount['RC'] + amount['RG'] <=Resources;
s.t. resourcesLimit_stage{s in Scenarios}:
	amount_stage['RB',s] + amount_stage['RC',s] + amount_stage['RG',s] <=Resources_stage[s];