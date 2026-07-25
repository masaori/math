#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules

#claim(none)[

  $z_1, z_2 in CC$ について、

  $r_1, r_2 in RR_(>=0), r_1 eq.not 0 and r_2 eq.not 0, theta_1, theta_2 in RR$ を用いて、

  $phi_("polar")(z_1) = [(r_1, theta_1)]_(~), phi_("polar")(z_2) = [(r_2, theta_2)]_(~)$ として、

  $
    arg^([0, 2pi))(z_1 z_2) = pi
  $

  だとする。

  このとき、
  $
    cases(
      arg^([0, 2pi))(z_1) + arg^([0, 2pi))(z_2) = pi & quad (exists m in ZZ "s.t." 0 <= theta_1 + theta_2 - 2m pi < 2pi),
      arg^([0, 2pi))(z_1) + arg^([0, 2pi))(z_2) = pi + 2pi & quad (exists m in ZZ "s.t." 2pi <= theta_1 + theta_2 - 2m pi < 4pi),
    )
  $

  #proof[

    $phi_("polar")$ の同型性 から、

    $
      arg^([0, 2pi))(z_1)
      &=
      s_([0, 2pi))("pr"_2(phi_("polar")(z_1)))
      \
      &=
      s_([0, 2pi))("pr"_2([(r_1, theta_1)]_(~)))
      \
      &=
      s_([0, 2pi))([theta_1]_(~_(angle)))
      \
      &=
      theta_1 - 2n_1 pi
    $

    $
      arg^([0, 2pi))(z_2)
      &=
      s_([0, 2pi))("pr"_2(phi_("polar")(z_2)))
      \
      &=
      s_([0, 2pi))("pr"_2([(r_2, theta_2)]_(~)))
      \
      &=
      s_([0, 2pi))([theta_2]_(~_(angle)))
      \
      &=
      theta_2 - 2n_2 pi
    $

    $
      arg^([0, 2pi))(z_1 z_2)
      &=
      s_([0, 2pi))("pr"_2(phi_("polar")(z_1 dot.op z_2)))
      \
      &=
      s_([0, 2pi))("pr"_2(phi_("polar")(z_1) dot.op phi_("polar")(z_2)))
      \
      &=
      s_([0, 2pi))("pr"_2([(r_1, theta_1)]_(~) dot.op [(r_2, theta_2)]_(~)))
      \
      &=
      s_([0, 2pi))("pr"_2([(r_1 r_2, theta_1 + theta_2)]_(~)))
      \
      &=
      s_([0, 2pi))([theta_1 + theta_2]_(~_(angle)))
    $

    また、$0 <= theta_1 - 2n_1 pi < 2pi$ を満たす $n_1 in ZZ$ と、 $0 <= theta_2 - 2n_2 pi < 2pi$ を満たす $n_2 in ZZ$ が存在して、

    $
      theta_1 + theta_2 - 2(n_1 + n_2) pi
      &=
      theta_1 -2n_1 pi + theta_2 - 2n_2 pi
      \
      &=
      arg^([0, 2pi))(z_1) + arg^([0, 2pi))(z_2)
    $

    #enum(numbering: "a)")[
      $0 <= theta_1 + theta_2 - 2(n_1 + n_2) pi < 2pi$ のとき、

      $
        s_([0, 2pi))([theta_1 + theta_2]_(~_(angle)))
        =
        theta_1 + theta_2 - 2(n_1 + n_2) pi
      $

      よって、

      $
        theta_1 + theta_2 - 2(n_1 + n_2) pi &= pi
        \
        theta_1 -2n_1 pi + theta_2 - 2n_2 pi &= pi
        \
        arg^([0, 2pi))(z_1) + arg^([0, 2pi))(z_2) &= pi
      $
    ][
      $2pi <= theta_1 + theta_2 - 2(n_1 + n_2) pi < 4pi$ のとき、

      $
        0 <= theta_1 + theta_2 - 2(n_1 + n_2 + 1) pi < 2pi
      $

      であるから、

      $
        s_([0, 2pi))([theta_1 + theta_2]_(~_(angle)))
        =
        theta_1 + theta_2 - 2(n_1 + n_2 + 1) pi
      $

      よって、

      $
        theta_1 + theta_2 - 2(n_1 + n_2 + 1) pi &= pi
        \
        theta_1 -2n_1 pi + theta_2 - 2n_2 pi - 2pi &= pi
        \
        arg^([0, 2pi))(z_1) + arg^([0, 2pi))(z_2) - 2pi &= pi
        \
        arg^([0, 2pi))(z_1) + arg^([0, 2pi))(z_2) &= pi + 2pi
      $
    ]

    以上から、$arg^([0, 2pi))(z_1 z_2) = pi$ であるとき、 $arg^([0, 2pi))(z_1), arg^([0, 2pi))(z_2)$ の間には以下の関係式が成立する。

    $
      cases(
        arg^([0, 2pi))(z_1) + arg^([0, 2pi))(z_2) = pi & quad (exists m in ZZ "s.t." 0 <= theta_1 + theta_2 - 2m pi < 2pi),
        arg^([0, 2pi))(z_1) + arg^([0, 2pi))(z_2) = pi + 2pi & quad (exists m in ZZ "s.t." 2pi <= theta_1 + theta_2 - 2m pi < 4pi),
      )
    $

    $qed$
  ]
]<range_of_args_of_multiple_of_complex_numbers>
