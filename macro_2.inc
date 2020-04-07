#BeginMacro(susceptible)
  0
#EndMacro

#BeginMacro(incubation)
  1
#EndMacro

#BeginMacro(infected)
  8
#EndMacro

#BeginMacro(recovered)
  16
#EndMacro

#BeginMacro(dead)
  -1
#EndMacro

#BeginMacro(imSusceptible)
  ((0,0)=0)
#EndMacro

#BeginMacro(imIncubating)
  (((0,0) != 0) and ((0,0) <= 7))
#EndMacro

#BeginMacro(imInfected)
  ((0,0)>0 and (0,0)<=15)
#EndMacro

#BeginMacro(imRecovered)
  (((0,0) > 8) and not ((0,0)>0 and (0,0)<=15))
#EndMacro

#BeginMacro(anyNeighborIsInfected)
( ((-1,-1)> 0 and (-1,-1)<=15) or  ((-1,0)> 0 and (-1,0)<=15) or 
  ((-1,1)> 0 and (-1,1)<=15) or
 ((0,-1)> 0 and (0,-1)<=15) or  ((0,0)> 0 and (0,0)<=15) or 
  ((0,1)> 0 and (0,1)<=15) or
((1,-1)> 0 and (1,-1)<=15) or  ((1,0)> 0 and (1,0)<=15) or 
  ((1,1)> 0 and (1,1)<=15) )
#EndMacro

#BeginMacro(gotInfected)
  (uniform(0,1) <= 0.4)
#EndMacro

#BeginMacro(died)
  (uniform(0,1) <= 0.005)
#EndMacro
