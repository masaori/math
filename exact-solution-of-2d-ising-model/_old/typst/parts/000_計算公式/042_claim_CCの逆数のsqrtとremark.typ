#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules

#claim([$CC$の逆数の$sqrt(dot)$])[
  $z in CC, z eq.not 0$について、

  $
    sqrt(1/z) = cases(
      1/sqrt(z) & quad (arg^([0, 2pi))(z) = 0),
      -(1/sqrt(z)) & quad (0 < arg^([0, 2pi))(z) < 2pi),
    )
  $

  #proof[

    $z in CC, z eq.not 0$について、

    $r in RR_(>0), theta in RR$を用いて、

    $phi_("polar")(z) = [(r, theta)]_(~)$ とする。

    また、$n in ZZ$ を用いて、

    $0 <= theta - 2n pi < 2pi$ とする。

    このとき、

    $
      arg^([0, 2pi))(z) = theta - 2n pi
    $

    また、

    $
      phi_("polar")(1 / z)
      &=
      phi_("polar")(z^(-1))
      \
      &=
      ([(r, theta)]_(~))^(-1) quad (because phi_("polar")"の同型性")
      \
      &=
      [(1/r, -theta)]_(~)
    $

    より、$-2pi < -theta + 2n pi <= 0$ であり、

    $
      arg^([0, 2pi))(1 / z)
      &=
      s_([0, 2pi))("pr"_2(phi_("polar")(1 / z)))
      \
      &=
      s_([0, 2pi))([-theta]_(~_(angle)))
      \
      &=
      cases(
        -theta - 2(-n)pi &quad (theta - 2n pi = 0),
        -theta - 2(-n - 1)pi &quad (0 < theta - 2n pi < 2pi),
      )
      \
      &=
      cases(
        -(theta - 2n pi) &quad (theta - 2n pi = 0),
        -(theta - 2n pi) + 2pi &quad (0 < theta - 2n pi < 2pi),
      )
      \
      &=
      cases(
        0 &quad (theta - 2n pi = 0),
        2pi - (theta - 2n pi) &quad (0 < theta - 2n pi < 2pi),
      )
    $

    だから、

    $
      arg^([0, 2pi))(z) + arg^([0, 2pi))(1 / z)
      &=
      cases(
        0 + 0 &quad (theta - 2n pi = 0),
        (theta - 2n pi) + (2pi - (theta - 2n pi)) &quad (0 < theta - 2n pi < 2pi),
      )
      \
      &=
      cases(
        0 &quad (theta - 2n pi = 0),
        2pi &quad (0 < theta - 2n pi < 2pi),
      )
    $

    $
      sqrt(z) dot.op sqrt(1 / z)
      &=
      cases(
        sqrt(z dot.op 1/z) & quad (theta - 2n pi = 0),
        -sqrt(z dot.op 1/z) & quad (0 < theta - 2n pi < 2pi),
      )
      quad (because #ref(<condition_of_commutativity_of_sqrt_and_product>))
      \
      &=
      cases(
        sqrt(1) & quad (theta - 2n pi = 0),
        -sqrt(1) & quad (0 < theta - 2n pi < 2pi),
      )
      \
      &=
      cases(
        1 & quad (theta - 2n pi = 0),
        -1 & quad (0 < theta - 2n pi < 2pi),
      )
    $

    以上から

    $
      sqrt(1/z) = cases(
        1/sqrt(z) & quad (theta - 2n pi = 0 <=> arg^([0, 2pi))(z) = 0),
        -(1/sqrt(z)) & quad (0 < theta - 2n pi < 2pi <=> 0 < arg^([0, 2pi))(z) < 2pi),
      )
    $
  ]
]<inverse_of_sqrt_cc>

#remark[
  
  $z in CC^(times)$ について、

  $
    sqrt(1/z) = cases(
        1/sqrt(z) & quad (arg^([0, 2pi))(z) = 0 <=> z in RR_(>0)),
        -(1/sqrt(z)) & quad (0 < arg^([0, 2pi))(z) < 2pi <=> z in.not RR_(>0)),
    )
  $
]
