#include(SIR_Hoya_macros.inc)
[top]
components : area

[area]
type : cell
width : 50
height : 50
delay : transport
defaultDelayTime : 1
border : wrapped
neighbors : 			area(-1,0) 
neighbors : area(0,-1)  area(0,0)  area(0,1)
neighbors : 			area(1,0) 
initialvalue : -1


localtransition : sir-hoya-rule

statevariables: population v c m i_infec i_rec i_sus
statevalues: 100 0.6 1.0 0.5 0.0 0.0 1.0
initialvariablesvalue: SIR_Hoya.var

neighborports : initial infec rec pop sus

[sir-hoya-rule]
rule : {~initial := 0; ~pop := $population; ~infec := $i_infec; ~sus := $i_sus; ~rec := $i_rec; }
 1 {(0,0)~initial = -1}

rule : {~pop := $population; ~infec := $i_infec; ~sus := $i_sus; ~rec := $i_rec; }
{$i_infec:= trunc(min((1 - #macro(e)) * (0,0)~infec + $v*(0,0)~sus*(0,0)~infec + (0,0)~sus*#macro(effect_neighbours),1)*100)/100;
$i_rec := trunc(min((0,0)~rec + #macro(e)*(0,0)~infec,1)*100)/100;
$i_sus := 1 - $i_rec - $i_infec;} 
1 { (0,0)~initial != -1 }









