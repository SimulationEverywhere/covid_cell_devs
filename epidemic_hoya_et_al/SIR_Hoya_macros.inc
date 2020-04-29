#BeginMacro(e) 
0.4
#EndMacro


#BeginMacro(effect_neighbours) 
( ((1,0)~pop / $population) * (1,0)~infec * $virulence * $connection * $movement  + 
((0,-1)~pop / $population) * (0,-1)~infec * $virulence * $connection * $movement + 
((0,1)~pop / $population) * (0,1)~infec * $virulence * $connection * $movement +
((-1,0)~pop / $population) * (-1,0)~infec * $virulence * $connection * $movement )
#EndMacro

