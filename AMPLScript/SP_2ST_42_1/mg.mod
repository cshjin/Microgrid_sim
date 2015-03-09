model;
param SIZE:=8760;
set Directions;
set Time := {1..SIZE-1};
param InitBattery;
param Demand;
param Resources;
param BatteryCapacity;
param TransitionPrice;
param ReservePrice;
param SellingPrice;
param BuyingPrice;
param Buying {t in Time};
param Selling {t in Time};
param DemandSeq {t in Time};
param ResourcesSeq {t in Time};
param InitBatterySeq {t in Time};
var amount{d in Directions} >=0;
param Cost{t in Time};


minimize cost:
    TransitionPrice * (amount['BC']+amount['BG']
        +amount['GB']+amount['RB']) +
    ReservePrice * (InitBattery-amount['BC'] - amount['BG']
        +amount['GB']+amount['RB']) +
    BuyingPrice * (amount['GB'] + amount['GC'] + InitBattery) -
    SellingPrice * (amount['BG'] + amount['RG']);

s.t. meetDemand:
    amount['BC'] + amount['GC'] + amount['RC'] 
        >= Demand;
s.t. batteryLimit:
    0 <= InitBattery-amount['BC'] - amount['BG']
        +amount['GB']+amount['RB'] <= BatteryCapacity;
s.t. resourcesLimit:
    amount['RB'] + amount['RC'] + amount['RG'] <=Resources;
data;

set Directions:= BC BG GB GC RB RC RG;

param InitBattery := 500;
param BatteryCapacity := 1000;
param TransitionPrice := 0.002;
param ReservePrice := 0.001;