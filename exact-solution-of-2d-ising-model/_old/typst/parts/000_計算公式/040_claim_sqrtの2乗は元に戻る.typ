#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules

#claim([sqrt の2乗は元に戻る])[
  $z in CC$ について、

  $
    sqrt(z) sqrt(z) = z
  $

  #proof[
    $z in CC$ について、

    $r in RR_(>=0), theta in RR$ を用いて

    $phi_("polar")(z) = [(r, theta)]_(~)$ とする。

    また、$n in ZZ$ を用いて、

    $-pi < theta - 2n pi <= pi (<=> (2n - 1)pi < theta <= (2n + 1)pi)$ とする。

    このとき、

    $
      sqrt(z)
      &=
      phi_("cartesian")
      (
        [(
          sqrt(r)^(RR_(>=0)), 
          theta/2 - n pi
        )]_(~)
      )
    $

    よって、

    $
      sqrt(z) sqrt(z)
      &=
      phi_("cartesian")
      (
        [(
          sqrt(r)^(RR_(>=0)), 
          theta/2 - n pi
        )]_(~)
      )
      phi_("cartesian")
      (
        [(
          sqrt(r)^(RR_(>=0)), 
          theta/2 - n pi
        )]_(~)
      )
      \
      &=
      phi_("cartesian")
      (
        [(
          sqrt(r)^(RR_(>=0)), 
          theta/2 - n pi
        )]_(~)
        dot.op
        [(
          sqrt(r)^(RR_(>=0)), 
          theta/2 - n pi
        )]_(~)
      )
      quad
      (
        because phi_("cartesian")"の同型性"
      )
      \
      &=
      phi_("cartesian")
      (
        [(
          sqrt(r)^(RR_(>=0)) dot.op sqrt(r)^(RR_(>=0)), 
          theta/2 - n pi + theta/2 - n pi
        )]_(~)
      )
      \
      &=
      phi_("cartesian")
      (
        [(
          r,
          theta - 2n pi 
        )]_(~)
      )
      quad
      (
        because sqrt(r)^(RR_(>=0)) "の定義" #ref(<definition_of_sqrt_r_positive>) "より"
      )
      \
      &=
      phi_("cartesian")
      (
        [(
          r,
          theta
        )]_(~)
      )
      quad
      (
        because (r, theta - 2n pi) ~ (r, theta)
      )
      \
      &=
      phi_("cartesian")
      (
        phi_("polar")(z)
      )
      \
      &=
      z
    $

    $qed$
  ]
]  
