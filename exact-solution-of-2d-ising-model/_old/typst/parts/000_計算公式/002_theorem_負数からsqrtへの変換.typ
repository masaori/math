#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules

#theorem([負数 $ -> sqrt("  ")$])[
  $x in RR_(< 0)$について、

  $
    x = -sqrt((-x)^2)^(RR_(>=0))
  $

  #proof[
    $
      x < 0
      \
      -sqrt(a)^(RR_(>=0)) = x "になるような" a
      \
      sqrt(a)^(RR_(>=0)) = -x
      \
      ("自乗して"a"になる実数のうち" a > 0 "のもの") = -x
      \
      ("自乗して"a"になる実数のうち" a > 0 "のもの")^2 = (-x)^2
      \
      a = (-x)^2
      \
      x = -sqrt((-x)^2)^(RR_(>=0))
    $
  ]
]<negative_number_to_sqrt>
