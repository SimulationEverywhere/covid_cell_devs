
#BeginMacro(local_cured) 
(( round(min($cr_5 * $i_inf_5, 1)*100) +
round(min($cr_4 * $i_inf_4, 1)*100) +
round(min($cr_3 * $i_inf_3, 1)*100) +
round(min($cr_2 * $i_inf_2, 1)*100) +
round(min($cr_1 * $i_inf_1, 1)*100) ) / 100 )
#EndMacro

#BeginMacro(internal_infected) 
( round(min(( 
$i_sus_0 * (
($v_6 * $i_inf_6) +
($v_5 * $i_inf_5) +
($v_4 * $i_inf_4) +
($v_3 * $i_inf_3) +
($v_2 * $i_inf_2) +
($v_1 * $i_inf_1)
)), 1)*100) / 100 )
#EndMacro

#BeginMacro(external_infected) 
( round(min((
$connection * $movement * $i_sus_0 * (
((1,0)~pop / $population) * $v_6 * (1,0)~inf_6 +
((1,0)~pop / $population) * $v_5 * (1,0)~inf_5 +
((1,0)~pop / $population) * $v_4 * (1,0)~inf_4 +
((1,0)~pop / $population) * $v_3 * (1,0)~inf_3 +
((1,0)~pop / $population) * $v_2 * (1,0)~inf_2 +
((1,0)~pop / $population) * $v_1 * (1,0)~inf_1
)), 1)*100) / 100 ) +
( round(min((
$connection * $movement * $i_sus_0 * (
((0,-1)~pop / $population) * $v_6 * (0,-1)~inf_6 +
((0,-1)~pop / $population) * $v_5 * (0,-1)~inf_5 +
((0,-1)~pop / $population) * $v_4 * (0,-1)~inf_4 +
((0,-1)~pop / $population) * $v_3 * (0,-1)~inf_3 +
((0,-1)~pop / $population) * $v_2 * (0,-1)~inf_2 +
((0,-1)~pop / $population) * $v_1 * (0,-1)~inf_1
)), 1)*100) / 100 ) +
( round(min((
$connection * $movement * $i_sus_0 * (
((0,1)~pop / $population) * $v_6 * (0,1)~inf_6 +
((0,1)~pop / $population) * $v_5 * (0,1)~inf_5 +
((0,1)~pop / $population) * $v_4 * (0,1)~inf_4 +
((0,1)~pop / $population) * $v_3 * (0,1)~inf_3 +
((0,1)~pop / $population) * $v_2 * (0,1)~inf_2 +
((0,1)~pop / $population) * $v_1 * (0,1)~inf_1
)), 1)*100) / 100 ) +
( round(min((
$connection * $movement * $i_sus_0 * (
((-1,0)~pop / $population) * $v_6 * (-1,0)~inf_6 +
((-1,0)~pop / $population) * $v_5 * (-1,0)~inf_5 +
((-1,0)~pop / $population) * $v_4 * (-1,0)~inf_4 +
((-1,0)~pop / $population) * $v_3 * (-1,0)~inf_3 +
((-1,0)~pop / $population) * $v_2 * (-1,0)~inf_2 +
((-1,0)~pop / $population) * $v_1 * (-1,0)~inf_1
)), 1)*100) / 100 )
#EndMacro