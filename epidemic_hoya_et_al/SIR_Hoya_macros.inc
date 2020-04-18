#BeginMacro(e) 
0.5
#EndMacro


#BeginMacro(effect_neighbours) 
( ((1,0)~pop / $population) * (1,0)~infec * $v * $c * $m  + 
((0,-1)~pop / $population) * (0,-1)~infec * $v * $c * $m + 
((0,1)~pop / $population) * (0,1)~infec * $v * $c * $m +
((-1,0)~pop / $population) * (-1,0)~infec * $v * $c * $m )
#EndMacro

