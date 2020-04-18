#include(VN.inc)
[top]
components : campus

[campus]
type : cell
dim : (59,100)
delay : transport
defaultDelayTime : 1000
border : nonwrapped

neighbors : 		  campus(-1,0) 
neighbors : campus(0,-1)  campus(0,0)  campus(0,1)
neighbors : 		  campus(1,0)

initialValue : 0
initialCellsValue : carleton.val
localtransition : rules

[rules]

rule : {if( #macro(gotInfected), #macro(infected), (0,0))} 1
     { (0,0)=0 and #macro(anyNeighborIsInfected)}

rule : { #macro(sick) }  7   { #macro(imAsymp) }

rule : {if( #macro(died), #macro(dead), (0,0)+1)} 1
            {#macro(imInfected)}

rule : {(0,0)} 1000 { t }
