#include(VN.inc)
[top]
components : store

[store]
type : cell
dim : (64,100)
delay : inertial
defaultDelayTime : 1
border : nonwrapped

neighbors :              store(0,-1)
neighbors : store(-1,0)  store(0,0)  store(1,0)
neighbors :              store(0,1)

initialValue : 0
initialCellsValue : covid_store.val
localtransition : infections

[infections]
rule : {if( #macro(gotInfected), #macro(infected), (0,0))} 1
     { (0,0)=0 and #macro(anyNeighborIsInfected)}

rule : { #macro(sick) }  7   { #macro(imAsymp) }

rule : {if( #macro(died), #macro(dead), (0,0)+1)} 1
            {#macro(imInfected)}

rule : {(0,0)} 1000 { t }
