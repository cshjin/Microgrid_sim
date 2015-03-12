/*
    MICROGRID model in AMPL
    * deterministic model
 */
model;
# total running hours
param SIZE:=8760;
# optimization variables x
set Directions;
# time t
set Time := {1..SIZE-1};
# parameter of initial battery in system
param InitBattery;
# parameter of demand at time t
param Demand;
# available resources at time t
param Resources;
# battery capacity at time t
param BatteryCapacity;
# transition cost per KWh 
param TransitionPrice;
# reserve cost per KWh
param ReservePrice;
# selling price per KWh
param SellingPrice;
# purchase price per KWh
param BuyingPrice;
# purchase amount at time t
param Buying {t in Time};
# sell amount at time t
param Selling {t in Time};
# demand amount at time t
param DemandSeq {t in Time};
# resources amount at time t
param ResourcesSeq {t in Time};
# pre-defined battery recharge amount at time t
param InitBatterySeq {t in Time};
# VARIABLE of 7 different directions of energy flow, x_{D} >= 0
var amount{d in Directions} >= 0;
# cost at time t, NOT the expected cost
param Cost{t in Time};

# total (expect) cost
minimize cost:
    TransitionPrice * (amount['BC']  
                    + amount['BG']
                    + amount['GB']
                    + amount['RB'] ) 
    + ReservePrice * (InitBattery 
                    - amount['BC'] 
                    - amount['BG']
                    + amount['GB'] 
                    + amount['RB']) 
    + BuyingPrice * (amount['GB'] 
                    + amount['GC'] 
                    + InitBattery) 
    - SellingPrice * (amount['BG'] 
                    + amount['RG']);

# constrain meet local demand
s.t. meetDemand:
    amount['BC'] + amount['GC'] + amount['RC'] >= Demand;

# meet battery capacity limitations 
s.t. batteryLimit:
    0 <= InitBattery-amount['BC'] - amount['BG'] + amount['GB'] + amount['RB'] <= BatteryCapacity;

# 
s.t. resourcesLimit:
    amount['RB'] + amount['RC'] + amount['RG'] <=Resources;
data;

set Directions:= BC BG GB GC RB RC RG;

param InitBattery := 500;
param BatteryCapacity := 1000;
param TransitionPrice := 0.002;
param ReservePrice := 0.001;