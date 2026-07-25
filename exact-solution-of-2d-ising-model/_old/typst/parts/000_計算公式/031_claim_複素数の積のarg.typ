#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules

#claim(none)[

  $z_1, z_2 in CC$ について、

  $r_1, r_2 in RR_(>=0), theta_1, theta_2 in RR$ を用いて、

  $phi_("polar")(z_1) = [(r_1, theta_1)]_(~), phi_("polar")(z_2) = [(r_2, theta_2)]_(~)$ とすると、

  $0 <= theta_1 - 2n_1 pi < 2pi, 0 <= theta_2 - 2n_2 pi < 2pi$ を満たす $n_1, n_2 in ZZ$ が存在して、

  $arg^([0, 2pi))(z_1) = theta_1 - 2n_1 pi, arg^([0, 2pi))(z_2) = theta_2 - 2n_2 pi$

  と書ける。

  このとき、
  $
    arg^([0, 2pi))(z_1 z_2)
    =
    cases(
      arg^([0, 2pi))(z_1) + arg^([0, 2pi))(z_2) & quad (0 <= theta_1 + theta_2 - 2 (n_1 + n_2) pi < 2 pi),
      arg^([0, 2pi))(z_1) + arg^([0, 2pi))(z_2) - 2 pi & quad (2 pi <= theta_1 + theta_2 - 2 (n_1 + n_2) pi < 4 pi)
    )
  $

  #proof[
    $
      arg^([0, 2pi))(z_1 z_2)
      &=
      s_([0, 2pi))("pr"_2(phi_("polar")(z_1 z_2)))
      \
      &=
      s_([0, 2pi))("pr"_2(phi_("polar")(z_1) phi_("polar")(z_2)))
      quad
      (because phi_("polar")"の同型性")
      \
      &=
      s_([0, 2pi))("pr"_2([(r_1, theta_1)]_(~) [(r_2, theta_2)]_(~)))
      \
      &=
      s_([0, 2pi))("pr"_2([(r_1 r_2, theta_1 + theta_2)]_(~)))
      \
      &=
      s_([0, 2pi))([theta_1 + theta_2]_(~_(angle)))
    $

    また、$0 <= theta_1 + theta_2 - 2 (n_1 + n_2) pi < 4 pi$ なので、以下のケースに分けて考える。

    a. $0 <= theta_1 + theta_2 - 2 (n_1 + n_2) pi < 2 pi$ の時、
    $
      s_([0, 2pi))([theta_1 + theta_2]_(~_(angle)))
      &=
      theta_1 + theta_2 - 2 (n_1 + n_2) pi
      \
      &=
      arg^([0, 2pi))(z_1) + 2n_1 pi + arg^([0, 2pi))(z_2) + 2n_2 pi - 2 (n_1 + n_2) pi
      \
      &=
      arg^([0, 2pi))(z_1) + arg^([0, 2pi))(z_2)
    $
    
    b. $2 pi <= theta_1 + theta_2 - 2 (n_1 + n_2) pi < 4 pi$ の時、
    $0 <= theta_1 + theta_2 - 2 (n_1 + n_2) pi - 2 pi = theta_1 + theta_2 - 2 (n_1 + n_2 + 1) pi < 2 pi$ だから,
    $
      s_([0, 2pi))([theta_1 + theta_2]_(~_(angle)))
      &=
      theta_1 + theta_2 - 2 (n_1 + n_2 + 1) pi
      \
      &=
      arg^([0, 2pi))(z_1) + 2n_1 pi + arg^([0, 2pi))(z_2) + 2n_2 pi - 2 (n_1 + n_2 + 1) pi
      \
      &=
      arg^([0, 2pi))(z_1) + arg^([0, 2pi))(z_2) - 2 pi
    $
  ]
]<arg_of_product_of_complex_numbers>
