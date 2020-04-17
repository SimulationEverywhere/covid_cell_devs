#BeginMacro(e) %recovery rate [0,1]
0.5
#EndMacro

#BeginMacro(v) %virulence of the epidemic [0,1]
  0.5
#EndMacro 

#BeginMacro(effect_neighbours)
0.45
#EndMacro

%( (((0,-1)~pop/$people)*$c*$m*#macro(v)*(0,-1)~inf) + 
%(0,1)~pop/$people)*$c*$m*#macro(v)*(0,1)~inf) +
%	((-1,0)~pop/$people)*$c*$m*#macro(v)*(-1,0)~inf)  +
%	((1,0)~pop/$people)*$c*$m*#macro(v)*(1,0)~inf) 
%	)
