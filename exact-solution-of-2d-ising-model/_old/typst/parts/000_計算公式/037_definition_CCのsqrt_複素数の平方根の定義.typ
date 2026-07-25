#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules

#definition([$CC$のsqrt])[
  $sqrt(dot.c): CC -> CC$ を以下のように定める。

  $z in CC$ について、

  $
    sqrt(z)
    :=
    phi_("cartesian")
    (
      [(
        sqrt("pr"_1(phi_("polar")(z)))^(RR_(>=0)), 
        1/2 dot.op s_([0, 2pi))("pr"_2(phi_("polar")(z)))
      )]_(~)
    )
  $
]
