#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules

#claim([$CC$の自乗の$arg$])[
  $z in CC$について、

  $r in RR_(>=0), theta in RR$ を用いて

  $phi_("polar")(z) = [(r, theta)]_(~)$ であるとき、

  $
    arg^([0, 2pi))(z^2)
    =
    cases(
      2 arg^([0, 2pi))(z) & quad (0 <= theta - 2n pi < pi <=> 0 <= arg^([0, 2pi))(z) < pi),
      2 arg^([0, 2pi))(z) - 2pi & quad (pi <= theta - 2n pi < 2pi <=> pi <= arg^([0, 2pi))(z) < 2pi),
    )
  $

  #proof[
    $z in CC$ について、

    $r in RR_(>=0), theta in RR$ を用いて

    $phi_("polar")(z) = [(r, theta)]_(~)$ であるとき、

    $0 <= theta - 2n_1 pi < 2pi$ を満たす $n_1 in ZZ$ が存在して、

    $arg^([0, 2pi))(z) = theta - 2n_1 pi$ である。

    また、

    $
      arg^([0, 2pi))(z^2)
      &=
      s_([0, 2pi))("pr"_2(phi_("polar")(z^2)))
      \
      &=
      s_([0, 2pi))("pr"_2(phi_("polar")(z) phi_("polar")(z)))
      quad
      (because phi_("polar")"の同型性")
      \
      &=
      s_([0, 2pi))("pr"_2([(r, theta)]_(~) [(r, theta)]_(~)))
      \
      &=
      s_([0, 2pi))("pr"_2([(r^2, 2 theta)]_(~)))
      \
      &=
      s_([0, 2pi))([2 theta]_(~_(angle)))
    $

    ここで、$0 <= theta - 2n_1 pi < 2pi$ より、$0 <= 2(theta - 2n_1 pi) < 4pi$ すなわち $0 <= 2theta - 4n_1 pi < 4pi$ である。

    以下のケースに分けて考える。

    a. $0 <= theta - 2n_1 pi < pi$ の時、
    $0 <= 2(theta - 2n_1 pi) < 2pi$ すなわち $0 <= 2theta - 4n_1 pi < 2pi$ だから、
    $
      s_([0, 2pi))([2 theta]_(~_(angle)))
      &=
      2 theta - 4n_1 pi
      \
      &=
      2 (theta - 2n_1 pi)
      \
      &=
      2 arg^([0, 2pi))(z)
    $

    b. $pi <= theta - 2n_1 pi < 2pi$ の時、
    $2pi <= 2(theta - 2n_1 pi) < 4pi$ すなわち $2pi <= 2theta - 4n_1 pi < 4pi$ だから、
    $0 <= 2theta - 4n_1 pi - 2pi = 2theta - 2(2n_1 + 1) pi < 2pi$ より、
    $
      s_([0, 2pi))([2 theta]_(~_(angle)))
      &=
      2 theta - 2(2n_1 + 1) pi
      \
      &=
      2 theta - 4n_1 pi - 2pi
      \
      &=
      2 (theta - 2n_1 pi) - 2pi
      \
      &=
      2 arg^([0, 2pi))(z) - 2pi
    $
  ]
]<range_of_args_of_square_of_complex_numbers>
