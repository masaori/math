#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules

#claim([$CC$の$sqrt(dot)$の逆数])[
  $z in CC$について、

  $
    (sqrt(z))^(-1)
    =
    1/sqrt(z)
    =
    cases(
      sqrt(1/z) & quad (arg^([0, 2pi))(z) = 0),
      -(sqrt(1/z)) & quad (0 < arg^([0, 2pi))(z) < 2pi),
    )
  $

  #proof[
    #ref(<inverse_of_sqrt_cc>)より。
  ]

]<sqrt_cc_of_inverse>

#remark[
  $z in CC^(times)$ について、

  $
    (sqrt(z))^(-1) = cases(
        sqrt(1/z) & quad (arg^([0, 2pi))(z) = 0 <=> z in RR_(>0)),
        -(sqrt(1/z)) & quad (0 < arg^([0, 2pi))(z) < 2pi <=> z in.not RR_(>0)),
    )
  $
]
