#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules

#claim([sqrt と 積が可換になる条件])[
  $z_1, z_2 in CC$ について、

  $r_1, r_2 in RR_(>=0), theta_1, theta_2 in RR$ を用いて

  $phi_("polar")(z_1) = [(r_1, theta_1)]_(~), phi_("polar")(z_2) = [(r_2, theta_2)]_(~)$

  とするとき、

  $
    sqrt(z_1 z_2)
    =
    cases(
      sqrt(z_1) sqrt(z_2) &quad (0 <= arg^([0, 2pi))(z_1) + arg^([0, 2pi))(z_2) < 2pi),
      -sqrt(z_1) sqrt(z_2) &quad (2pi <= arg^([0, 2pi))(z_1) + arg^([0, 2pi))(z_2) < 4pi),
    )
  $

  #proof[
    $z_1, z_2 in CC$ について、

    $r_1, r_2 in RR_(>=0), theta_1, theta_2 in RR$ で

    $phi_("polar")(z_1) = [(r_1, theta_1)]_(~), phi_("polar")(z_2) = [(r_2, theta_2)]_(~)$

    とするとき、

    $
      sqrt(z_1 z_2)
      &=
      phi_("cartesian")
      (
        [(
          sqrt("pr"_1(phi_("polar")(z_1 z_2)))^(RR_(>=0)), 
          1/2 dot.op s_([0, 2pi))("pr"_2(phi_("polar")(z_1 z_2)))
        )]_(~)
      )
      \
      &=
      phi_("cartesian")
      (
        [(
          sqrt("pr"_1(phi_("polar")(z_1) phi_("polar")(z_2)))^(RR_(>=0)), 
          1/2 dot.op s_([0, 2pi))("pr"_2(phi_("polar")(z_1) phi_("polar")(z_2)))
        )]_(~)
      )
      quad
      (because phi_("polar")"の同型性")
      \
      &=
      phi_("cartesian")
      (
        [(
          sqrt("pr"_1([(r_1, theta_1)]_(~) [(r_2, theta_2)]_(~)))^(RR_(>=0)), 
          1/2 dot.op s_([0, 2pi))("pr"_2([(r_1, theta_1)]_(~) [(r_2, theta_2)]_(~)))
        )]_(~)
      )
      \
      &=
      phi_("cartesian")
      (
        [(
          sqrt("pr"_1([(r_1 r_2, theta_1 + theta_2)]_(~)))^(RR_(>=0)), 
          1/2 dot.op s_([0, 2pi))("pr"_2([(r_1 r_2, theta_1 + theta_2)]_(~)))
        )]_(~)
      )
      \
      &=
      phi_("cartesian")
      (
        [(
          sqrt(r_1 r_2)^(RR_(>=0)), 
          1/2 dot.op s_([0, 2pi))([theta_1 + theta_2]_(~_(angle)))
        )]_(~)
      )
      \
      &=
      (
        sqrt(r_1 r_2)^(RR_(>=0)) cos(1/2 dot.op s_([0, 2pi))([theta_1 + theta_2]_(~_(angle)))),
        sqrt(r_1 r_2)^(RR_(>=0)) sin(1/2 dot.op s_([0, 2pi))([theta_1 + theta_2]_(~_(angle))))
      )
    $

    $
      sqrt(z_1) sqrt(z_2)
      &=
      phi_("cartesian")
      (
        [(
          sqrt("pr"_1(phi_("polar")(z_1)))^(RR_(>=0)), 
          1/2 dot.op s_([0, 2pi))("pr"_2(phi_("polar")(z_1)))
        )]_(~)
      )
      phi_("cartesian")
      (
        [(
          sqrt("pr"_1(phi_("polar")(z_2)))^(RR_(>=0)), 
          1/2 dot.op s_([0, 2pi))("pr"_2(phi_("polar")(z_2)))
        )]_(~)
      )
      \
      &=
      phi_("cartesian")
      (
        [(
          sqrt("pr"_1([(r_1, theta_1)]_(~)))^(RR_(>=0)), 
          1/2 dot.op s_([0, 2pi))("pr"_2([(r_1, theta_1)]_(~)))
        )]_(~)
      )
      phi_("cartesian")
      (
        [(
          sqrt("pr"_1([(r_2, theta_2)]_(~)))^(RR_(>=0)), 
          1/2 dot.op s_([0, 2pi))("pr"_2([(r_2, theta_2)]_(~)))
        )]_(~)
      )
      \
      &=
      phi_("cartesian")
      (
        [(
          sqrt(r_1)^(RR_(>=0)), 
          1/2 dot.op s_([0, 2pi))([theta_1]_(~_(angle)))
        )]_(~)
      )
      phi_("cartesian")
      (
        [(
          sqrt(r_2)^(RR_(>=0)), 
          1/2 dot.op s_([0, 2pi))([theta_2]_(~_(angle)))
        )]_(~)
      )
      \
      &=
      (
        sqrt(r_1)^(RR_(>=0)) cos(1/2 dot.op s_([0, 2pi))([theta_1]_(~_(angle)))),
        sqrt(r_1)^(RR_(>=0)) sin(1/2 dot.op s_([0, 2pi))([theta_1]_(~_(angle))))
      )
      (
        sqrt(r_2)^(RR_(>=0)) cos(1/2 dot.op s_([0, 2pi))([theta_2]_(~_(angle)))),
        sqrt(r_2)^(RR_(>=0)) sin(1/2 dot.op s_([0, 2pi))([theta_2]_(~_(angle))))
      )
      \
      &=
      //   CC := RR^2 に "掛け算" (a, b) dot.op (c, d) := (a c - b d, a d + b c) "を入れたもの"–
      (
        sqrt(r_1)^(RR_(>=0)) cos(1/2 dot.op s_([0, 2pi))([theta_1]_(~_(angle))))
          sqrt(r_2)^(RR_(>=0)) cos(1/2 dot.op s_([0, 2pi))([theta_2]_(~_(angle))))
        -
        sqrt(r_1)^(RR_(>=0)) sin(1/2 dot.op s_([0, 2pi))([theta_1]_(~_(angle))))
          sqrt(r_2)^(RR_(>=0)) sin(1/2 dot.op s_([0, 2pi))([theta_2]_(~_(angle)))),
        \
        &quad quad sqrt(r_1)^(RR_(>=0)) cos(1/2 dot.op s_([0, 2pi))([theta_1]_(~_(angle))))
          sqrt(r_2)^(RR_(>=0)) sin(1/2 dot.op s_([0, 2pi))([theta_2]_(~_(angle))))
        +
        sqrt(r_1)^(RR_(>=0)) sin(1/2 dot.op s_([0, 2pi))([theta_1]_(~_(angle))))
          sqrt(r_2)^(RR_(>=0)) cos(1/2 dot.op s_([0, 2pi))([theta_2]_(~_(angle))))
      )
      \
      &=
      (
        sqrt(r_1)^(RR_(>=0)) sqrt(r_2)^(RR_(>=0))
        (
          cos(1/2 dot.op s_([0, 2pi))([theta_1]_(~_(angle))))
          cos(1/2 dot.op s_([0, 2pi))([theta_2]_(~_(angle))))
          -
          sin(1/2 dot.op s_([0, 2pi))([theta_1]_(~_(angle))))
          sin(1/2 dot.op s_([0, 2pi))([theta_2]_(~_(angle))))
        ),
        \
        &quad quad sqrt(r_1)^(RR_(>=0)) sqrt(r_2)^(RR_(>=0))
        (
          cos(1/2 dot.op s_([0, 2pi))([theta_1]_(~_(angle))))
          sin(1/2 dot.op s_([0, 2pi))([theta_2]_(~_(angle))))
          +
          sin(1/2 dot.op s_([0, 2pi))([theta_1]_(~_(angle))))
          cos(1/2 dot.op s_([0, 2pi))([theta_2]_(~_(angle))))
        )
      )
      \
      &=
      (
        sqrt(r_1)^(RR_(>=0)) sqrt(r_2)^(RR_(>=0))
        (
          cos(1/2 dot.op s_([0, 2pi))([theta_1]_(~_(angle))) + 1/2 dot.op s_([0, 2pi))([theta_2]_(~_(angle))))
        ),
        \
        &quad quad sqrt(r_1)^(RR_(>=0)) sqrt(r_2)^(RR_(>=0))
        (
          cos(1/2 dot.op s_([0, 2pi))([theta_1]_(~_(angle))) + 1/2 dot.op s_([0, 2pi))([theta_2]_(~_(angle))))
        )
      )
      \
      &=
      (
        sqrt(r_1 r_2)^(RR_(>=0))
        cos(1/2 dot.op (s_([0, 2pi))([theta_1]_(~_(angle))) + s_([0, 2pi))([theta_2]_(~_(angle)))))
        ,
        sqrt(r_1 r_2)^(RR_(>=0))
        sin(1/2 dot.op (s_([0, 2pi))([theta_1]_(~_(angle))) + s_([0, 2pi))([theta_2]_(~_(angle)))))
      )
    $

    i. $r_1 = 0 or r_2 = 0$ のとき、

    $sqrt(r_1 r_2)^(RR_(>=0)) = 0$ より、
    
    $
      sqrt(z_1 z_2) = sqrt(z_1) sqrt(z_2)
    $

    ii. $r_1 eq.not 0 and r_2 eq.not 0$ のとき、

    $n_1, n_2 in ZZ$ で、

    $
      0 <= theta_1 - 2n_1 pi < 2pi
    $
    $
      0 <= theta_2 - 2n_2 pi < 2pi
    $

    を満たすようなものがそれぞれただ一つ存在する。

    このとき、

    $
      cos(1/2 dot.op (s_([0, 2pi))([theta_1]_(~_(angle))) + s_([0, 2pi))([theta_2]_(~_(angle)))))
      &=
      cos(1/2 dot.op (theta_1 - 2n_1 pi + theta_2 - 2n_2 pi))
      \
      &=
      cos((theta_1 + theta_2)/2 - (n_1 + n_2) pi)
      \
      &=
      cases(
        cos((theta_1 + theta_2)/2) & quad (n_1 + n_2"は偶数"),
        -cos((theta_1 + theta_2)/2) & quad (n_1 + n_2"は奇数")
      )
    $

    同様に

    $
      sin(1/2 dot.op (s_([0, 2pi))([theta_1]_(~_(angle))) + s_([0, 2pi))([theta_2]_(~_(angle)))))
      &=
      sin(1/2 dot.op (theta_1 - 2n_1 pi + theta_2 - 2n_2 pi))
      \
      &=
      sin((theta_1 + theta_2)/2 - (n_1 + n_2) pi)
      \
      &=
      cases(
        sin((theta_1 + theta_2)/2) & quad (n_1 + n_2"は偶数"),
        -sin((theta_1 + theta_2)/2) & quad (n_1 + n_2"は奇数")
      )
    $

    また、

    $
      0 <= theta_1 + theta_2 - 2(n_1 + n_2) pi < 4pi
    $

    であるから、

    
    ii.a $0 <= theta_1 + theta_2 - 2(n_1 + n_2) pi < 2pi$ のとき、

    $
      cos(1/2 dot.op s_([0, 2pi))([theta_1 + theta_2]_(~_(angle))))
      &=
      cos(1/2 dot.op (theta_1 + theta_2 - 2(n_1 + n_2) pi))
      \
      &=
      cos((theta_1 + theta_2)/2 - (n_1 + n_2) pi)
      \
      &=
      cases(
        cos((theta_1 + theta_2)/2) & quad (n_1 + n_2"は偶数"),
        -cos((theta_1 + theta_2)/2) & quad (n_1 + n_2"は奇数")
      )
    $

    同様に

    $
      sin(1/2 dot.op s_([0, 2pi))([theta_1 + theta_2]_(~_(angle))))
      &=
      sin(1/2 dot.op (theta_1 + theta_2 - 2(n_1 + n_2) pi))
      \
      &=
      sin((theta_1 + theta_2)/2 - (n_1 + n_2) pi)
      \
      &=
      cases(
        sin((theta_1 + theta_2)/2) & quad (n_1 + n_2"は偶数"),
        -sin((theta_1 + theta_2)/2) & quad (n_1 + n_2"は奇数")
      )
    $

ii.b $2pi <= theta_1 + theta_2 - 2(n_1 + n_2) pi < 4pi$ のとき、

    $
      0 <= theta_1 + theta_2 - 2(n_1 + n_2 + 1) pi < 2pi
    $

    より、

    $
      cos(1/2 dot.op s_([0, 2pi))([theta_1 + theta_2]_(~_(angle))))
      &=
      cos(1/2 dot.op (theta_1 + theta_2 - 2(n_1 + n_2 + 1) pi))
      \
      &=
      cos((theta_1 + theta_2)/2 - (n_1 + n_2 + 1) pi)
      \
      &=
      cases(
        cos((theta_1 + theta_2)/2) & quad (n_1 + n_2 + 1"は偶数"),
        -cos((theta_1 + theta_2)/2) & quad (n_1 + n_2 + 1"は奇数")
      )
      \
      &=
      cases(
        -cos((theta_1 + theta_2)/2) & quad (n_1 + n_2"は偶数"),
        cos((theta_1 + theta_2)/2) & quad (n_1 + n_2"は奇数")
      )
    $

    同様に

    $
      sin(1/2 dot.op s_([0, 2pi))([theta_1 + theta_2]_(~_(angle))))
      &=
      sin(1/2 dot.op (theta_1 + theta_2 - 2(n_1 + n_2 + 1) pi))
      \
      &=
      sin((theta_1 + theta_2)/2 - (n_1 + n_2 + 1) pi)
      \
      &=
      cases(
        sin((theta_1 + theta_2)/2) & quad (n_1 + n_2 + 1"は偶数"),
        -sin((theta_1 + theta_2)/2) & quad (n_1 + n_2 + 1"は奇数")
      )
      \
      &=
      cases(
        -sin((theta_1 + theta_2)/2) & quad (n_1 + n_2"は偶数"),
        sin((theta_1 + theta_2)/2) & quad (n_1 + n_2"は奇数")
      )
    $

    よって、

    $
      sqrt(z_1 z_2)
      &=
      cases(
        sqrt(z_1) sqrt(z_2) & quad ((r_1 = 0 or r_2 = 0) or exists n_1, n_2 in ZZ "s.t." 0 <= theta_1 + theta_2 - 2(n_1 + n_2) pi < 2pi <=> 0 <= arg^([0, 2pi))(z_1) + arg^([0, 2pi))(z_2) < 2pi),
        -sqrt(z_1) sqrt(z_2) & quad (exists n_1, n_2 in ZZ "s.t." 2pi <= theta_1 + theta_2 - 2(n_1 + n_2) pi < 4pi <=> 2pi <= arg^([0, 2pi))(z_1) + arg^([0, 2pi))(z_2) < 4pi),
      )
    $

    $qed$
  ]
]<condition_of_commutativity_of_sqrt_and_product>
