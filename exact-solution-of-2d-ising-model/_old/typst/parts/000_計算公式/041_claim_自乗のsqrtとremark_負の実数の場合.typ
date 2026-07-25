#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules

#claim([自乗の$sqrt(dot)$])[
  $z in CC$について、
  $
    z
    &= 
    cases(
      sqrt(z^2) &quad (0 <= arg^([0, 2pi))(z) < pi),
      -sqrt(z^2) &quad (pi <= arg^([0, 2pi))(z) < 2pi),
    )
  $

  #proof[
    $z in CC$ について、

    $r in RR_(>=0), theta in RR$ を用いて

    $phi_("polar")(z) = [(r, theta)]_(~)$ とする。

    また、$n in ZZ$ を用いて、

    $0 <= theta - 2n pi < 2pi (<=> 2n pi <= theta < (2n + 2)pi)$ とする。

    このとき、$#ref(<condition_of_commutativity_of_sqrt_and_product>)$より、

    $
      sqrt(z) sqrt(z)
      &= 
      cases(
        sqrt(z^2) &quad (0 <= arg^([0, 2pi))(z) + arg^([0, 2pi))(z) < 2pi),
        -sqrt(z^2) &quad (2pi <= arg^([0, 2pi))(z) + arg^([0, 2pi))(z) < 4pi),
      )
      \
      &= 
      cases(
        sqrt(z^2) &quad (0 <= 2 arg^([0, 2pi))(z) < 2pi),
        -sqrt(z^2) &quad (2pi <= 2 arg^([0, 2pi))(z) < 4pi),
      )
      \
      &= 
      cases(
        sqrt(z^2) &quad (0 <= arg^([0, 2pi))(z) < pi),
        -sqrt(z^2) &quad (pi <= arg^([0, 2pi))(z) < 2pi),
      )
    $
  ]

  $sqrt(z) sqrt(z) = z$ より、$qed$
]<square_of_sqrt>

#remark[
  $z in CC$について、$Re(z) < 0, Im(z) = 0$ のとき、

  (すなわち、$z in RR_(<0)$とみなせるとき)

  $arg^([0, 2pi))(z) = pi$ であるから、

  $
    z = -sqrt(z^2)
  $
]
