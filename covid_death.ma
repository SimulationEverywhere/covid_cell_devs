#include(macro_2.inc)
[top]
components : population

[population]
type : cell
dim : (100,100)
delay : transport
defaultDelayTime : 1
border : nowrapped
neighbors : population(-1,-1) population(-1,0) population(-1,1) 
neighbors : population(0,-1) population(0,0) population(0,1) 
neighbors : population(1,-1) population(1,0) population(1,1)

initialvalue : 0
InitialCellsValue : covid.val

localtransition : infections

[infections]
rule : {(0,0)} 1 {#macro(imSusceptible) and not #macro(anyNeighborIsInfected)}
rule : {if( #macro(gotInfected), #macro(incubation), (0,0))} 1 {#macro(imSusceptible) and #macro(anyNeighborIsInfected)}
rule : {if( #macro(died), #macro(dead), (0,0)+1)} 1 {#macro(imInfected)}
rule : {(0,0)} 1 {#macro(imRecovered)}

rule : {(0,0)} 1 { t }
