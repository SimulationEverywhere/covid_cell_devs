#include(SIR_Hoya_macros.inc)
[top]
components : population

[population]
type : cell
dim : (100,100)
delay : transport
defaultDelayTime : 1
border : nowrapped
neighbors : population(0,-1) population(0,0) population(0,1) 
neighbors :                  population(-1,0) 
neighbors :                  population(1,0) 

initialvalue : 0
%InitialCellsValue : SIR_Hoya.val

statevariables: people %population in the cell
statevariables: c %connectivy between cells
% 1 - 3 ways of transportation
% 0.6 - 2 ways of transportation
% 0.3 - 1 way of transportation
% 0 - no transportation
% We are assuming same connectivity for all cell, but in the original model, we should have a c for each neighbour cell

statevariables: m
%movement factor [0, 1] probability of an infected individual from a neighbour cell moved to here. We are assuming same for all cells, but we may have a different one for each cell.

statevariables: i_sus i_inf i_rec
statevalues: 10 1 0.5 0.9 0.1 0

NeighborPorts : sus inf rec pop

localtransition : infections


[infections]

%IT DOES NOT WORK
%rule : {~pop := $people;} { $i_rec := (#macro(e)+(0,1)~inf);} 1000 { t } 

%IT DOES WORK
%rule : {~pop := $people;} { $i_rec := #macro(e);} 1000 { t }

%IT DOES WORK
rule : {~pop := $i_rec;} { $i_rec := #macro(e);} 1000 { t }  

%IT DOES NOT WORK
%rule : {~pop := $i_rec+(0,1)~inf;} { $i_rec := #macro(e);} 1000 { t }  

%IT DOES WORK
rule : {~pop := $i_rec;} { $i_rec := #macro(e);} 1000 { (0,0)~pop = 10 } 

 	% 
	%~inf:= (1-#macro(e)) * (0,0)~inf + #macro(v)*(0,0)~sus*(0,0)~inf+(0,0)~sus* #macro(effect_neighbours);
	%~sus := (0,0)~sus - #macro(v)*(0,0)~sus*(0,0)~inf - (0,0)~sus* #macro(effect_neighbours); 

% neighbors : population(-1,-1) population(-1,0) population(-1,1) 
% neighbors : population(1,-1) population(1,0) population(1,1)
