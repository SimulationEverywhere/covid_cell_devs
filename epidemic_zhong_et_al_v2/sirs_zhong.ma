#include(sirs_zhong_macros.inc)
[top]
components : area

[area]
type : cell
width : 50
height : 50
delay : transport
defaultDelayTime : 1
border : wrapped
neighbors : 			area(-1,0)
neighbors : area(0,-1)  area(0,0)  area(0,1)
neighbors : 			area(1,0)
initialvalue : -1

localtransition : sirs-zhong-rule

statevariables: population connection movement cured_rate t_i t_r i_sus_0 i_inf_1 i_inf_2 i_inf_3 i_inf_4 i_inf_5 i_inf_6 i_rec_7 i_rec_8 i_rec_9 i_rec_10 i_rec_11 i_rec_12 i_rec_13 v_1 v_2 v_3 v_4 v_5 v_6
statevalues: 100 1 0.1 0.0 6 7 1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.6 0.6 0.6 0.6 0.6 0.6
initialvariablesvalue: sirs_zhong.var

neighborports : initial pop sus_0 inf_1 inf_2 inf_3 inf_4 inf_5 inf_6 rec_7 rec_8 rec_9 rec_10 rec_11 rec_12 rec_13

[sirs-zhong-rule]
rule : {~initial := 0; ~pop := $population; ~sus_0 := $i_sus_0; ~inf_1 := $i_inf_1; ~inf_2 := $i_inf_2; ~inf_3 := $i_inf_3; ~inf_4 := $i_inf_4; ~inf_5 := $i_inf_5; ~inf_6 := $i_inf_6; ~rec_7 := $i_rec_7; ~rec_8 := $i_rec_8; ~rec_9 := $i_rec_9; ~rec_10 := $i_rec_10; ~rec_11 := $i_rec_11; ~rec_12 := $i_rec_12; ~rec_13 := $i_rec_13;}
 1 {(0,0)~initial = -1}

rule : {
~pop := $population; ~sus_0 := $i_sus_0; ~inf_1 := $i_inf_1; ~inf_2 := $i_inf_2; ~inf_3 := $i_inf_3; ~inf_4 := $i_inf_4; ~inf_5 := $i_inf_5; ~inf_6 := $i_inf_6; ~rec_7 := $i_rec_7; ~rec_8 := $i_rec_8; ~rec_9 := $i_rec_9; ~rec_10 := $i_rec_10; ~rec_11 := $i_rec_11; ~rec_12 := $i_rec_12; ~rec_13 := $i_rec_13;
}
{
$i_rec_13 := $i_rec_12;
$i_rec_12 := $i_rec_11;
$i_rec_11 := $i_rec_10;
$i_rec_10 := $i_rec_9;
$i_rec_9 := $i_rec_8;
$i_rec_8 := $i_rec_7;
$i_rec_7 := $i_inf_6 + #macro(local_cured);

$i_inf_6 := round(min((1 - $cured_rate) * $i_inf_5, 1)*100)/100;
$i_inf_5 := round(min((1 - $cured_rate) * $i_inf_4, 1)*100)/100;
$i_inf_4 := round(min((1 - $cured_rate) * $i_inf_3, 1)*100)/100;
$i_inf_3 := round(min((1 - $cured_rate) * $i_inf_2, 1)*100)/100;
$i_inf_2 := round(min((1 - $cured_rate) * $i_inf_1, 1)*100)/100;
$i_inf_1 := #macro(internal_infected) + #macro(external_infected);

$i_sus_0 := 1 - $i_inf_1 - $i_inf_2 - $i_inf_3 - $i_inf_4 - $i_inf_5 - $i_inf_6 - $i_rec_7 - $i_rec_8 - $i_rec_9 - $i_rec_10 - $i_rec_11 - $i_rec_12 - $i_rec_13;

}
1 { (0,0)~initial != -1 }









