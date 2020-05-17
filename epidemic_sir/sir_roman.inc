#BeginMacro(recovery)
0.4
#EndMacro


#BeginMacro(i_effect_moore)
min
(
  (0,0)~sus,
  (0,0)~sus * $virulence *
  (
    (0,0)~infec + $connection * $movement / (0,0)~pop *
    (
      (-1,-1)~pop * (-1,-1)~infec + (-1,0)~pop * (-1,0)~infec + (-1,1)~pop * (-1,1)~infec +
      (0,-1)~pop * (0,-1)~infec + (0,1)~pop * (0,1)~infec +
      (1,-1)~pop * (1,-1)~infec + (1,0)~pop * (1,0)~infec + (1,1)~pop * (1,1)~infec
    )
  )
)
#EndMacro

#BeginMacro(i_effect_von_neumann)
min
(
  (0,0)~sus,
  (0,0)~sus * $virulence *
  (
    (0,0)~infec + $connection * $movement / (0,0)~pop *
    (
      (1,0)~pop * (1,0)~infec + (-1,0)~pop * (-1,0)~infec +
      (0,1)~pop * (0,1)~infec + (0,-1)~pop * (0,-1)~infec
    )
  )
)
#EndMacro
