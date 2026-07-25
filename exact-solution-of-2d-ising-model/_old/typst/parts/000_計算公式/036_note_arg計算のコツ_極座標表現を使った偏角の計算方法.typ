#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules

#note[
  $arg$計算のコツ：

  $phi_("polar")(z_1) = [(r_1, theta_1)]_(~), phi_("polar")(z_2) = [(r_2, theta_2)]_(~)$

  で、

  $arg^([0, 2pi))(z_1), arg^([0, 2pi))(z_2)$ の範囲や値がわかっていて、$z_1, z_2$ の和や積の $arg$ について考えたいときは

  一度、以下の表現に直してから計算すると機械的に進むことがある。

  $
    exists n_1 in ZZ "s.t." 0 <= theta_1 - 2n_1 pi < 2pi,
    \
    exists n_2 in ZZ "s.t." 0 <= theta_2 - 2n_2 pi < 2pi
  $

  例: $arg^([0, 2pi))(z_1 z_2)$ について考えるときは、
  $
    arg^([0, 2pi))(z_1 z_2)
    &=
    s_([0, 2pi))("pr"_2(phi_("polar")(z_1 z_2)))
    \
    &=
    s_([0, 2pi))("pr"_2(phi_("polar")(z_1) phi_("polar")(z_2)))
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

  みたいなところまで辿り着ければ、上記不等式を変形するなりして、

  $
    ? <= theta_1 + theta_2 - 2(n_1 + n_2) pi < ?
  $

  このような不等式から、$s_([0, 2pi))([theta_1 + theta_2]_(~_(angle)))$ の値の範囲を考えることができる(はず)
]
