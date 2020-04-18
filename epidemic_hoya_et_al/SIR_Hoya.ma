#include(SIR_Hoya_macros.inc)
[top]
components : area

[area]
type : cell
width : 21
height : 21
delay : transport
defaultDelayTime : 100
border : wrapped
neighbors : 			area(-1,0) 
neighbors : area(0,-1)  area(0,0)  area(0,1)
neighbors : 			area(1,0) 
initialvalue : 0


localtransition : sir-hoya-rule

statevariables: population v c m
statevalues: 10 0.5 1 0.7


neighborports : value infec rec pop sus

[sir-hoya-rule]
rule : { ~pop := $population;
~infec:= (1 - #macro(e)) * (0,0)~infec + $v*(0,0)~sus*(0,0)~infec + (0,0)~sus*#macro(effect_neighbours);
~sus := (0,0)~sus - $v*(0,0)~sus*(0,0)~infec - (0,0)~sus*#macro(effect_neighbours);
~rec := (0,0)~rec + #macro(e)*(0,0)~infec;
} 100 { t }


