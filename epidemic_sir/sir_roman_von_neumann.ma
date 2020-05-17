#include(sir_roman.inc)
[top]
components : area

[area]
type : cell
width : 50
height : 50
delay : transport
defaultDelayTime : 1
border : wrapped
neighbors :             area(-1,0)
neighbors : area(0,-1)  area(0,0)  area(0,1)
neighbors :             area(1,0)
initialvalue : -1


localtransition : sir-roman-rule

statevariables: population virulence connection movement i_sus i_infec i_rec
statevalues: 100 0.6 1.0 0.5 1.0 0.0 0.0
initialvariablesvalue: sir_roman.var

neighborports : initial infec rec pop sus

[sir-roman-rule]
rule : {~initial := 0; ~pop := $population; ~infec := $i_infec; ~sus := $i_sus; ~rec := $i_rec; }
 1 {(0,0)~initial = -1}

rule : {~pop := $population; ~infec := $i_infec; ~sus := $i_sus; ~rec := $i_rec; }
{
$i_rec := round(((0,0)~rec + #macro(recovery) * (0,0)~infec)*100)/100;
$i_infec:= round(((1 - #macro(recovery)) * (0,0)~infec + #macro(i_effect_von_neumann))*100)/100;
$i_sus := 1 - $i_rec - $i_infec;}
1 { (0,0)~initial != -1 }
