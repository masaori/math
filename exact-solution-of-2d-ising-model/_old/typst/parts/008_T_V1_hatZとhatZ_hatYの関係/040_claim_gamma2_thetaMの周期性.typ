#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules

#claim([$gamma_2(theta_M) = gamma_2(theta_(-M))$、$gamma_2(-theta_M) = gamma_2(-theta_(-M))$])[
  $
    gamma_2(theta_M) = gamma_2(theta_(-M)),
    quad
    gamma_2(-theta_M) = gamma_2(-theta_(-M))
  $

  #proof[
    $theta_M = 2pi$、$theta_(-M) = -2pi$ より $e^(sqrt(-1) theta_M) = e^(2pi sqrt(-1)) = 1 = e^(-2pi sqrt(-1)) = e^(sqrt(-1) theta_(-M))$、$cos theta_M = cos theta_(-M) = 1$、$sin theta_M = sin theta_(-M) = 0$。$#ref(<def_A_theta>)$ より、

    $
      gamma_2(theta_M)
      &=
      sqrt(-1)
      e^(sqrt(-1) theta_M)
      s_2^*
      (c_1 cos theta_M - sqrt(-1) sin theta_M - s_1 c_2)
      \
      &=
      sqrt(-1)
      dot.op 1
      dot.op
      s_2^*
      (c_1 dot.op 1 - sqrt(-1) dot.op 0 - s_1 c_2)
      \
      &=
      sqrt(-1)
      e^(sqrt(-1) theta_(-M))
      s_2^*
      (c_1 cos theta_(-M) - sqrt(-1) sin theta_(-M) - s_1 c_2)
      \
      &=
      gamma_2(theta_(-M))
    $

    $
      gamma_2(-theta_M)
      &=
      sqrt(-1)
      e^(-sqrt(-1) theta_M)
      s_2^*
      (c_1 cos(-theta_M) - sqrt(-1) sin(-theta_M) - s_1 c_2)
      \
      &=
      sqrt(-1)
      dot.op 1
      dot.op
      s_2^*
      (c_1 dot.op 1 - sqrt(-1) dot.op 0 - s_1 c_2)
      \
      &=
      gamma_2(-theta_(-M))
    $
  ]
]<gamma2_theta_M_periodicity>
