#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules

#claim([$CC$の逆数の$arg$])[
  $z in CC$について、

  $r in RR_(>=0), theta in RR$ を用いて

  $phi_("polar")(z) = [(r, theta)]_(~)$ であるとき、

  $
    arg^([0, 2pi))(1/z)
    =
    arg^([0, 2pi))(z^(-1))
    =
    cases(
      0 & quad (arg^([0, 2pi))(z) = 0),
      2pi - arg^([0, 2pi))(z) & quad (0 < arg^([0, 2pi))(z) < 2pi),
    )
  $

  #proof[
    $z in CC$ について、

    $r in RR_(>=0), theta in RR$ を用いて

    $phi_("polar")(z) = [(r, theta)]_(~)$ であるとき、

    $0 <= theta - 2n pi < 2pi$ を満たす $n in ZZ$ が存在して、

    $-2pi < -theta - 2 (-n) pi <= 0$ であり、

    $
      -2pi < -theta - 2 (-n) pi
      &<=>
      -2pi + 2pi < -theta - 2 (-n) pi + 2pi
      \
      &<=>
      0 < -theta - 2 (-n - 1) pi
    $

    であるから、

    $
      arg^([0, 2pi))(z^(-1))
      &=
      s_([0, 2pi))("pr"_2(phi_("polar")(z^(-1))))
      \
      &=
      s_([0, 2pi))("pr"_2((phi_("polar")(z))^(-1)))
      quad
      (because phi_("polar")"の同型性")
      \
      &=
      s_([0, 2pi))("pr"_2(([(r, theta)]_(~))^(-1)))
      \
      &=
      s_([0, 2pi))("pr"_2([(1/r, -theta)]_(~)))
      \
      &=
      s_([0, 2pi))([-theta]_(~_(angle)))
      \
      &=
      cases(
        -theta - 2 (-n) pi & quad (theta - 2n pi = 0),
        -theta - 2 (-n - 1) pi & quad (0 < theta - 2n pi < 2pi),
      )
      \
      &=
      cases(
        -theta - 2 (-n) pi & quad (theta - 2n pi = 0),
        -theta - 2 (-n) pi + 2pi & quad (0 < theta - 2n pi < 2pi),
      )
      \
      &=
      cases(
        -(theta - 2n pi) & quad (theta - 2n pi = 0),
        -(theta - 2n pi) + 2pi & quad (0 < theta - 2n pi < 2pi),
      )
      \
      &=
      cases(
        0 & quad (theta - 2n pi = 0),
        2pi - (theta - 2n pi) & quad (0 < theta - 2n pi < 2pi),
      )
      \
      &=
      cases(
        0 & quad (arg^([0, 2pi))(z) = 0),
        2pi - arg^([0, 2pi))(z) & quad (0 < arg^([0, 2pi))(z) < 2pi),
      )
    $
    $qed$
  ]
]<range_of_args_of_reciprocal_of_complex_numbers>
