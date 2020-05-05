
#BeginMacro(local_cured) 
(( trunc(min($cured_rate * $i_lat_5, 1)*100) + 
trunc(min($cured_rate * $i_inf_4, 1)*100) + 
trunc(min($cured_rate * $i_inf_3, 1)*100) + 
trunc(min($cured_rate * $i_inc_2, 1)*100) + 
trunc(min($cured_rate * $i_inc_1, 1)*100) ) / 100 )
#EndMacro

#BeginMacro(internal_infected) 
( truncate(min(( $contact_rate * 
((%i_sus_0 * $population) / $area) *
%i_sus_0 * 
($i_lat_6 + $i_lat_5 + $i_inf_4 + $i_inf_3 + $i_incv_2 + $i_inc_1)
) / $p, 1)*100) / 100 )
#EndMacro

#BeginMacro(external_infected) 
( truncate(min(( $connection *
$contact_rate * 
((%i_sus_0 * $population) / $area) *
%i_sus_0 * 
((1,0)~lat_6 + (1,0)~lat_5 + (1,0)~inf_4 + (1,0)~inf_3 + (1,0)~inc_2 + (1,0)~inc_1)
) / $p, 1)*100) / 100 )
+
( truncate(min(( $connection *
$contact_rate * 
((%i_sus_0 * $population) / $area) *
%i_sus_0 * 
((0,-1)~lat_6 + (0,-1)~lat_5 + (0,-1)~inf_4 + (0,-1)~inf_3 + (0,-1)~inc_2 + (0,-1)~inc_1)
) / $p, 1)*100) / 100 )
+
( truncate(min(( $connection *
$contact_rate * 
((%i_sus_0 * $population) / $area) *
%i_sus_0 * 
((0,1)~lat_6 + (0,1)~lat_5 + (0,1)~inf_4 + (0,1)~inf_3 + (0,1)~inc_2 + (0,1)~inc_1)
) / $p, 1)*100) / 100 )
+
( truncate(min(( $connection *
$contact_rate * 
((%i_sus_0 * $population) / $area) *
%i_sus_0 * 
((-1,0)~lat_6 + (-1,0)~lat_5 + (-1,0)~inf_4 + (-1,0)~inf_3 + (-1,0)~inc_2 + (-1,0)~inc_1)
) / $p, 1)*100) / 100 )
#EndMacro