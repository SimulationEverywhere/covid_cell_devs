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

statevariables: population connection movement cured_rate t_i t_r i_sus_0 i_inf_1 i_inf_2 i_inf_3 i_inf_4 i_inf_5 i_inf_6 i_inf_7 i_inf_8 i_inf_9 i_inf_10 i_inf_11 i_inf_12 i_inf_13 i_inf_14 i_inf_15 i_inf_16 i_inf_17 i_inf_18 i_inf_19 i_inf_20 i_inf_21 i_inf_22 i_rec_23 i_rec_24 i_rec_25 i_rec_26 i_rec_27 i_rec_28 v_1 v_2 v_3 v_4 v_5 v_6 v_7 v_8 v_9 v_10 v_11 v_12 v_13 v_14 v_15 v_16 v_17 v_18 v_19 v_20 v_21 v_22
statevalues: 100 1 0.6 0.07 22 6 1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.17 0.17 0.17 0.17 0.17 0.17 0.17 0.17 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01
initialvariablesvalue: sirs_zhong.var

neighborports : initial pop sus_0 inf_1 inf_2 inf_3 inf_4 inf_5 inf_6 inf_7 inf_8 inf_9 inf_10 inf_11 inf_12 inf_13 inf_14 inf_15 inf_16 inf_17 inf_18 inf_19 inf_20 inf_21 inf_22 rec_23 rec_24 rec_25 rec_26 rec_27 rec_28

[sirs-zhong-rule]
rule : {~initial := 0; ~pop := $population; ~sus_0 := $i_sus_0; ~inf_1 := $i_inf_1; ~inf_2 := $i_inf_2; ~inf_3 := $i_inf_3; ~inf_4 := $i_inf_4; ~inf_5 := $i_inf_5; ~inf_6 := $i_inf_6; ~inf_7 := $i_inf_7; ~inf_8 := $i_inf_8; ~inf_9 := $i_inf_9; ~inf_10 := $i_inf_10; ~inf_11 := $i_inf_11; ~inf_12 := $i_inf_12; ~inf_13 := $i_inf_13; ~inf_14 := $i_inf_14; ~inf_15 := $i_inf_15; ~inf_16 := $i_inf_16; ~inf_17 := $i_inf_17; ~inf_18 := $i_inf_18; ~inf_19 := $i_inf_19; ~inf_20 := $i_inf_20; ~inf_21 := $i_inf_21; ~inf_22 := $i_inf_22; ~rec_23 := $i_rec_23; ~rec_24 := $i_rec_24; ~rec_25 := $i_rec_25; ~rec_26 := $i_rec_26; ~rec_27 := $i_rec_27; ~rec_28 := $i_rec_28;}
 1 {(0,0)~initial = -1}

rule : {
~pop := $population; ~sus_0 := $i_sus_0; ~inf_1 := $i_inf_1; ~inf_2 := $i_inf_2; ~inf_3 := $i_inf_3; ~inf_4 := $i_inf_4; ~inf_5 := $i_inf_5; ~inf_6 := $i_inf_6; ~inf_7 := $i_inf_7; ~inf_8 := $i_inf_8; ~inf_9 := $i_inf_9; ~inf_10 := $i_inf_10; ~inf_11 := $i_inf_11; ~inf_12 := $i_inf_12; ~inf_13 := $i_inf_13; ~inf_14 := $i_inf_14; ~inf_15 := $i_inf_15; ~inf_16 := $i_inf_16; ~inf_17 := $i_inf_17; ~inf_18 := $i_inf_18; ~inf_19 := $i_inf_19; ~inf_20 := $i_inf_20; ~inf_21 := $i_inf_21; ~inf_22 := $i_inf_22; ~rec_23 := $i_rec_23; ~rec_24 := $i_rec_24; ~rec_25 := $i_rec_25; ~rec_26 := $i_rec_26; ~rec_27 := $i_rec_27; ~rec_28 := $i_rec_28;
}
{
$i_rec_28 := $i_rec_27;
$i_rec_27 := $i_rec_26;
$i_rec_26 := $i_rec_25;
$i_rec_25 := $i_rec_24;
$i_rec_24 := $i_rec_23;
$i_rec_23 := $i_inf_22 + #macro(local_cured);

$i_inf_22 := round(min((1 - $cured_rate) * $i_inf_21, 1)*100)/100;
$i_inf_21 := round(min((1 - $cured_rate) * $i_inf_20, 1)*100)/100;
$i_inf_20 := round(min((1 - $cured_rate) * $i_inf_19, 1)*100)/100;
$i_inf_19 := round(min((1 - $cured_rate) * $i_inf_18, 1)*100)/100;
$i_inf_18 := round(min((1 - $cured_rate) * $i_inf_17, 1)*100)/100;
$i_inf_17 := round(min((1 - $cured_rate) * $i_inf_16, 1)*100)/100;
$i_inf_16 := round(min((1 - $cured_rate) * $i_inf_15, 1)*100)/100;
$i_inf_15 := round(min((1 - $cured_rate) * $i_inf_14, 1)*100)/100;
$i_inf_14 := round(min((1 - $cured_rate) * $i_inf_13, 1)*100)/100;
$i_inf_13 := round(min((1 - $cured_rate) * $i_inf_12, 1)*100)/100;
$i_inf_12 := round(min((1 - $cured_rate) * $i_inf_11, 1)*100)/100;
$i_inf_11 := round(min((1 - $cured_rate) * $i_inf_10, 1)*100)/100;
$i_inf_10 := round(min((1 - $cured_rate) * $i_inf_9, 1)*100)/100;
$i_inf_9 := round(min((1 - $cured_rate) * $i_inf_8, 1)*100)/100;
$i_inf_8 := round(min((1 - $cured_rate) * $i_inf_7, 1)*100)/100;
$i_inf_7 := round(min((1 - $cured_rate) * $i_inf_6, 1)*100)/100;
$i_inf_6 := round(min((1 - $cured_rate) * $i_inf_5, 1)*100)/100;
$i_inf_5 := round(min((1 - $cured_rate) * $i_inf_4, 1)*100)/100;
$i_inf_4 := round(min((1 - $cured_rate) * $i_inf_3, 1)*100)/100;
$i_inf_3 := round(min((1 - $cured_rate) * $i_inf_2, 1)*100)/100;
$i_inf_2 := round(min((1 - $cured_rate) * $i_inf_1, 1)*100)/100;
$i_inf_1 := #macro(internal_infected) + #macro(external_infected);

$i_sus_0 := 1 - $i_inf_1 - $i_inf_2 - $i_inf_3 - $i_inf_4 - $i_inf_5 - $i_inf_6 - $i_inf_7 - $i_inf_8 - $i_inf_9 - $i_inf_10 - $i_inf_11 - $i_inf_12 - $i_inf_13 - $i_inf_14 - $i_inf_15 - $i_inf_16 - $i_inf_17 - $i_inf_18 - $i_inf_19 - $i_inf_20 - $i_inf_21 - $i_inf_22 - $i_rec_23 - $i_rec_24 - $i_rec_25 - $i_rec_26 - $i_rec_27 - $i_rec_28;

}
1 { (0,0)~initial != -1 }









