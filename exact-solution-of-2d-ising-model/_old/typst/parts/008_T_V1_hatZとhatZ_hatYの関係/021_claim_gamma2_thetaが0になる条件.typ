#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules
#claim([$gamma_2(theta)$が$0$になる条件])[
  $mu in cal(M)$について、
  
  $
    gamma_2(theta_mu)
    =
    0
    & <=>
    cases(
      sin(theta_mu) &= 0,
      c_2 s_1 - c_1 cos(theta_mu) &= 0,
    )
    \
    & <=>
    cases(
      theta_mu &= 0\, plus.minus pi\, plus.minus 2 pi\, dots,
      c_2 s_1 &= c_1 cos(theta_mu),
    )
    \
    & <=>
    cases(
      mu &= plus.minus M, 
      c_2 s_1 &= c_1 cos(theta_mu),
    )
  $

  #proof[

  ]
]<gamma_2_theta_is_0>
