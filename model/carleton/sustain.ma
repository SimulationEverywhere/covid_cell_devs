
[top]
components : campus

[campus]
type : cell
dim : (59,100)
delay : transport
defaultDelayTime : 1000
border : nonwrapped

neighbors : campus(-1,-1) campus(-1,0) campus(-1,1) 
neighbors : campus(0,-1)  campus(0,0)  campus(0,1)
neighbors : campus(1,-1)  campus(1,0)  campus(1,1)

initialValue : 0
initialCellsValue : sustain.val
localtransition : rules

[rules]

rule: {(0,0)}   0   { t }
