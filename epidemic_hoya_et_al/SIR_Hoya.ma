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
InitialCellsValue : SIR_Hoya.val

localtransition : infections

[infections]

rule : {(0,0)} 1000 { t }  

% neighbors : population(-1,-1) population(-1,0) population(-1,1) 
% neighbors : population(1,-1) population(1,0) population(1,1)
