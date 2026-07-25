#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules

#claim(none)[
  $z in CC$ について、

  $r in RR_(>=0), theta in RR$ を用いて

  $phi_("polar")(z) = [(r, theta)]_(~)$ であり、

  $n in ZZ$ を用いて、

  $0 <= theta - 2n pi < 2pi (<=> 2n pi <= theta < (2n + 1) dot 2pi)$ であるとき、

  $
    sqrt(z)
    &=
    phi_("cartesian")
    (
      [
        sqrt(r)^(RR_(>=0)), 
        1/2 dot.op s_([0, 2pi))([theta]_(~_(angle)))
      ]_(~)
    )
    \
    &=
    phi_("cartesian")
    (
      [
        sqrt(r)^(RR_(>=0)), 
        1/2 dot.op (theta - 2n pi)
      ]_(~)
    )
    \
    &=
    phi_("cartesian")
    (
      [
        sqrt(r)^(RR_(>=0)), 
        theta/2 - n pi
      ]_(~)
    )
  $

  #proof[
    TODO: 
  ]
]
